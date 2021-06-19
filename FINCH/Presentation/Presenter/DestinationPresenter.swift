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
  var destination: [DestinationPresenterDataDetails]
}
struct DestinationPresenterDataDetails {
  var destination: String
  var time: String
  var imageName: String = ""
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
  
  func fetchData(){
    let display = DisplayStationUseCase(service: StationService())
    display.delegate = self
    display.fetchData{ _, _ in }
  }
  
  func getNumberOfSection() -> Int{
    return self.type == .bus ? busData.count : trainData.count
  }
  
  func getNumberOfRows(for section: Int) -> Int{
    return self.type == .bus  ? busData[section].destination.count : trainData[section].destination.count
  }
  
  func getTitleFor(in section: Int, with indexOf: Int) -> String{
    
    return self.type == .bus ? busData[section].destination[indexOf].destination : trainData[section].destination[indexOf].destination
    
  }
  func getImage(in section: Int, with indexOf: Int) -> UIImage?{
    switch self.type{
    case .bus:
      return UIImage(named: busData[section].destination[indexOf].imageName)
    case .train:
      return UIImage(named:trainData[section].destination[indexOf].imageName)
    }
  }
  func getTotalStops(in section: Int, with indexOf: Int) -> String{
    let time = self.type == .bus ? busData[section].destination[indexOf].time : trainData[section].destination[indexOf].time
    
    return "Departure time: \(time)"
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
        destination: bus.stops.map({ (stops) -> DestinationPresenterDataDetails in
          print(stops.busbay)
          return DestinationPresenterDataDetails(
            destination: stops.shape,
            time: stops.departure,
            imageName: stops.busbay
          )
        }))
    })
    
    self.trainData = trainStation.map({ (train) -> DestinationPresenterData in
      return DestinationPresenterData(
        header: train.name,
        destination: train.stops.map({ (stops) -> DestinationPresenterDataDetails in
          return DestinationPresenterDataDetails(
            destination: stops.shape,
            time: stops.departureTime
          )
        }))
    })
    
    delegate?.update(index: 0)
  }
}
