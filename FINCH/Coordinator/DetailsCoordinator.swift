//
//  DetailsCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit


final class DetailsCoordinator: Coordinator{
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigator: UINavigationController){
    self.navigationController = navigator
  }
  
  
  func start() {
    
    let detailsVC: DetailsViewController = .initialize()
    print(detailsVC)
    navigationController.present(detailsVC, animated: true, completion: nil)
    
  }
  
  
  
}
