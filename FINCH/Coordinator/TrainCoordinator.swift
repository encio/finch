//
//  TrainCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit



class TrainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigation: UINavigationController){
    self.navigationController = navigation
  }
  
  func start() {
    let vc: DestinationViewController = .initialize()
    vc.pageName = "Train"
    vc.tabBarItem = UITabBarItem(title: "Train".uppercased(), image: UIImage(named: "train-100.png"), tag: 1)
    navigationController.pushViewController(vc, animated: false)
  }
  
  
}
