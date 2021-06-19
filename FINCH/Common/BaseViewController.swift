//
//  BaseViewController.swift
//  FINCH
//
//  Created by Peter Encio on 6/20/21.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  let alert = UIAlertController(title: "", message: "Please Wait ...", preferredStyle: .alert)
  
  func showLoading(){
    alert.title = nil
    alert.message = waitingQuotes[Int.random(in: 0..<3)]
   
//    let loadingIndicator = UIActivityIndicatorView(frame:  CGRect(origin: self.view.center, size: CGSize(width: 20, height: 20)))
//    loadingIndicator.hidesWhenStopped = true
//    loadingIndicator.style = UIActivityIndicatorView.Style.large
//    loadingIndicator.startAnimating();
    
//    alert.view.addSubview(loadingIndicator)
    self.present(alert, animated: true, completion: nil)
  }
  
  func hidLoading()  {
    self.alert.dismiss(animated: true, completion: nil)
  }

  
  let waitingQuotes: [String] = [
    "Our willingness to wait reveals the value we place on the object we're waiting for",
    "Everything comes in time to him who knows how to wait",
    "Patience is not simply the ability to wait - it's how we behave while we're waiting."
  ]
  
}
