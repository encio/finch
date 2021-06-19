//
//  TrainCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit


final class TrainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigation: UINavigationController){
    self.navigationController = navigation
  }
  
  func start() {
    let vc: DestinationViewController = .initialize()
    vc.tabBarItem = UITabBarItem(title: "Train".uppercased(), image: UIImage(named: "train-100.png"), tag: 1)
    let presenter = DestinationPresenter(delegate: vc, type: .train)
    vc.presenter = presenter
    presenter.shouldSegue = {[unowned self] (station) in
      self.gotoDetails(station: station)
    }
    navigationController.pushViewController(vc, animated: false)
  }
  
  func gotoDetails(station:  String){
    let child = DetailsCoordinator(navigator: navigationController)
    childCoordinators.append(child)
    child.start(station: station)
  }
  
  
}
