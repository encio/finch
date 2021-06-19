//
//  MainCoordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

final class BusCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigation: UINavigationController){
    self.navigationController = navigation
  }
  
  func start() {
    let vc: DestinationViewController = .initialize()
    vc.tabBarItem = UITabBarItem(title: "Bus".uppercased(), image: UIImage(named: "bus-100.png"), tag: 0)
    let presenter = DestinationPresenter(delegate: vc, type: .bus)
    vc.presenter = presenter
    presenter.shouldSegue = {[unowned self] (station) in
      self.gotoDetails(station: station)
    }
    navigationController.pushViewController(vc, animated: false)
  }
  
  func gotoDetails(station: String){
    let child = DetailsCoordinator(navigator: self.navigationController)
    childCoordinators.append(child)
    child.start(station: station)
  }
  
}
