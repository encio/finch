//
//  DestinationPresenter.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation
import UIKit


protocol DestinationPresenterDelegate: AnyObject {
  func update(index: Int)
}

typealias DestinationPresenterDelegateAlias = DestinationPresenterDelegate & UIViewController

class DestinationPresenter {
  
  weak var delegate: DestinationPresenterDelegate?
  
  
  init(delegate: DestinationPresenterDelegateAlias) {
    self.delegate = delegate
  }
  var title: String = "Bus"
  
  func didTapCell(index: Int){
    delegate?.update(index: index)
  }
  
  
  
}
