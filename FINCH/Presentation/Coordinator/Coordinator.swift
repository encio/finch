//
//  Coordinator.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation
import UIKit

protocol Coordinator {
  var childCoordinators: [Coordinator] {get set}
  var navigationController: UINavigationController {get set}
  
  func start()
}
