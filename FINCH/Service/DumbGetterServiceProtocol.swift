//
//  DumbGetterServiceProtocol.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(String)
}


//Doing this for the sake of simplicity!
protocol DumbGetterServiceProtocol {
  associatedtype Data

  func get( completionHandler: @escaping(Result<Data>) -> Void)
}
