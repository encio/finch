//
//  MainTabBarViewController.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    let busCoordinator = BusCoordinator(navigation: UINavigationController())
    let trainCoordinator = TrainCoordinator(navigation: UINavigationController())
    override func viewDidLoad() {
      super.viewDidLoad()
      
      initializeCoordinator()
      
      viewControllers = [busCoordinator.navigationController, trainCoordinator.navigationController]
      
      tabBar.barTintColor = .barColor
      tabBar.tintColor = .barItemColor
      
      StationService().get { _ in}
    }
    
  
  private func initializeCoordinator(){
    busCoordinator.start()
    trainCoordinator.start()
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
