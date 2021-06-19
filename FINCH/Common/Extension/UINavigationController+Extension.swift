//
//  UINavigationController+Extension.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit


extension UINavigationController {
  
  func setStatusBar(backgroundColor: UIColor) {
    let statusBarFrame: CGRect
    if #available(iOS 13.0, *) {
      statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
    } else {
      statusBarFrame = UIApplication.shared.statusBarFrame
      UIApplication.shared.statusBarStyle = .lightContent
    }
    let statusBarView = UIView(frame: statusBarFrame)
    statusBarView.backgroundColor = backgroundColor
    view.addSubview(statusBarView)
    
  }
  
  
  func configure(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, preferredLargeTitle: Bool = true) {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
      navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
      navBarAppearance.backgroundColor = backgoundColor
      
      self.navigationBar.standardAppearance = navBarAppearance
      self.navigationBar.compactAppearance = navBarAppearance
      self.navigationBar.scrollEdgeAppearance = navBarAppearance
      
      self.navigationBar.prefersLargeTitles = preferredLargeTitle
      self.navigationBar.isTranslucent = false
      self.navigationBar.tintColor = tintColor
      
      
    } else {
      // Fallback on earlier versions
      self.navigationBar.barTintColor = backgoundColor
      self.navigationBar.tintColor = tintColor
      self.navigationBar.isTranslucent = false
    }
  }
  
}
