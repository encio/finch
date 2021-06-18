//
//  MainCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

class BusCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigation: UINavigationController){
    self.navigationController = navigation
  }
  
  func start() {
    let vc: DestinationViewController = .initialize()
    vc.pageName = "Bus"
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
    navigationController.pushViewController(vc, animated: false)
  }
  
  
}
