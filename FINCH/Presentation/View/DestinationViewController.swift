//
//  ViewController.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

final class DestinationViewController: BaseViewController {
  
  var presenter: DestinationPresenter?
  
  @IBOutlet weak var stationTableView: UITableView!{
    didSet{
      stationTableView.dataSource = self
      stationTableView.delegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    presenter?.fetchData()
    setupTableView()
    showLoading()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = presenter?.title
    navigationController?.configure(largeTitleColor: .barItemColor, backgoundColor: .barColor, tintColor: .systemRed, preferredLargeTitle: true)
    navigationController?.setStatusBar(backgroundColor: .barColor)

  }
  
  
  private func setupTableView(){
    self.stationTableView.sectionHeaderHeight = UITableView.automaticDimension;
    self.stationTableView.estimatedSectionHeaderHeight = 50;
  }
  
}
extension DestinationViewController: DestinationPresenterDelegate{
  func update(index: Int) {
    DispatchQueue.main.async {
      self.hidLoading()
      self.stationTableView.reloadData()
    }
  }
}


extension DestinationViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter?.getNumberOfRows(for: section) ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    presenter?.getNumberOfSection() ?? 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.didTapCell(index: indexPath)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "stationIdentifier") else {
      return UITableViewCell()
    }
    
    cell.textLabel?.text = presenter?.getTitleFor(in: indexPath.section, with: indexPath.row)
    cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.lineBreakMode = .byWordWrapping
    cell.textLabel?.textColor = UIColor.black
    cell.imageView?.image = presenter?.getImage(in: indexPath.section, with: indexPath.row)
    cell.detailTextLabel?.text = presenter?.getTotalStops(in: indexPath.section, with: indexPath.row)
    cell.detailTextLabel?.textColor = UIColor.gray
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let label = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: tableView.frame.size.width, height: 35))
    label.text = presenter?.getHeader(in: section)
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = UIColor.black
    return label
  }
}

