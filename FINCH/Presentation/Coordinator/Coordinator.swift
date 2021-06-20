//
//  Coordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] {get set}
  var navigationController: UINavigationController {get set}
  
  func start()
  func remove(child: Coordinator)
}

extension Coordinator{
  func remove(child: Coordinator){
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child{
        childCoordinators.remove(at: index)
        break
      }
    }
  }
}
