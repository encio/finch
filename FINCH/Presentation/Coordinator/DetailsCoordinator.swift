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
  var parentCoordinator: Coordinator?
  init(navigator: UINavigationController){
    self.navigationController = navigator
  }
  
  func start(station: String) {
    let detailsVC: DetailsViewController = .initialize()
    detailsVC.coordinator = self
    detailsVC.searchLocation = station
    navigationController.present(detailsVC, animated: true, completion: nil)
  }
  func start() {}
  
  func didFinish(coordinator: Coordinator) {
    parentCoordinator?.remove(child: coordinator)
  }
  deinit {
    print("Deinit")
  }
  
  
  
}
