//
//  MainCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigation: UINavigationController){
    self.navigationController = navigation
  }
  
  
  
  func start() {
    let vc: MainTabBarViewController = .initialize()
    navigationController.pushViewController(vc, animated: false)
  }
  
  
}
