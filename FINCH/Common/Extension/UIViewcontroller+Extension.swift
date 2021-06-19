//
//  UIViewcontroller+Extension.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit

extension UIViewController {
  static func initialize<T>() -> T{
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
    return controller
    
  }
}
