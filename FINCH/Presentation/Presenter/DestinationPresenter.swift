//
//  DestinationPresenter.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation
import UIKit




enum stationType{
  case bus
  case train
}

struct DestinationPresenterData {
  var header: String
  var destination: [String]
}

protocol DestinationPresenterDelegate: AnyObject {
  func update(index: Int)
}

typealias DestinationPresenterDelegateAlias = DestinationPresenterDelegate & UIViewController

class DestinationPresenter {
  
  weak var delegate: DestinationPresenterDelegate?
  var type: stationType
  var shouldSegue: (()-> Void)?
  init(delegate: DestinationPresenterDelegateAlias, type: stationType = .bus) {
    self.delegate = delegate
    self.type = type
  }
  var title: String {
    get{
      switch self.type{
      case .bus:
        return "BUS"
      case .train:
        return "TRAIN"
      }
    }
  }
  
  private var busData = [DestinationPresenterData]()
  private var trainData = [DestinationPresenterData]()
  
  func getHeader(in section: Int) -> String {
    switch type {
    case .bus:
      return busData[section].header
    default:
      return trainData[section].header
    }
 
  }
  
  func getNumberOfSection() -> Int{
    return self.type == .bus ? busData.count : trainData.count
  }
  
  func getNumberOfRows(for section: Int) -> Int{
    return self.type == .bus  ? busData[section].destination.count : trainData[section].destination.count
  }
  
  func getTitleFor(in section: Int, with indexOf: Int) -> String{
    return self.type == .bus ? busData[section].destination[indexOf] : trainData[section].destination[indexOf]
  }
  
  func getTotalStops(in section: Int, with indexOf: Int) -> String{
    return self.type == .bus ? "\(busData[section].destination.count) stop(s)" : "\(trainData[section].destination.count) stop(s)"
  }
  func didTapCell(index: Int){
    
    shouldSegue?()
  }
  
}

extension DestinationPresenter: DisplayStationUseCaseDelegate{
  func fetchData(busStation: [BusStationModel], trainStation: [TrainStationModel]) {
    self.busData = busStation.map({ (bus) -> DestinationPresenterData in
      return DestinationPresenterData(
        header: bus.name,
        destination: bus.stops.map({ (stops) -> String in
          stops.shape
        }))
    })
    
    self.trainData = trainStation.map({ (train) -> DestinationPresenterData in
      return DestinationPresenterData(
        header: train.name,
        destination: train.stops.map({ (stops) -> String in
          stops.shape
        }))
    })
    
    delegate?.update(index: 0)
  }
}
