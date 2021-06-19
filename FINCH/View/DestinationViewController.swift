//
//  ViewController.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

final class DestinationViewController: UIViewController {
  
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
    setupTableView()
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
    print("update \(index)")
  }
}


extension DestinationViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    3
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    4
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.didTapCell(index: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "stationIdentifier") else {
      return UITableViewCell()
    }
    cell.textLabel?.text = "Downsview Station"
    cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.lineBreakMode = .byWordWrapping
    cell.textLabel?.textColor = UIColor.black
    cell.imageView?.image = UIImage()
    cell.detailTextLabel?.text = "(4) Left"
    cell.detailTextLabel?.textColor = UIColor.gray
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let label = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: tableView.frame.size.width, height: 35))
    label.text = "Finch Station Subway Platform"
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = UIColor.black
    return label
  }
}

