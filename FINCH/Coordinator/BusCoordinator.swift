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
    vc.tabBarItem = UITabBarItem(title: "Bus".uppercased(), image: UIImage(named: "bus-100.png"), tag: 0)
    navigationController.pushViewController(vc, animated: false)
  }
  
  
}
