//
//  DisplayRouteUseCase.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation

struct Keys{
  
  enum finchStopKey: String {
    case trainStop = "finch_station_subway_platform"
    case busStop = "finch_station_bus_bay"
  }
}

protocol DisplayStationUseCaseDelegate: AnyObject{
  func fetchData(busStation: [BusStationModel], trainStation: [TrainStationModel])
}


class DisplayStationUseCase{
  private let service: DumbGetterServiceProtocol
  weak var delegate: DisplayStationUseCaseDelegate?
  init(service: DumbGetterServiceProtocol){
    self.service = service
  }
  
  func fetchData(completion: @escaping(_ busModel: [BusStationModel], _ trainModel: [TrainStationModel])-> Void) {
    service.get {
      switch $0{
      case .Success(let station):
        let bus = self.getBusStation(station: station)
        let train = self.getTrainStation(station: station)
        completion(bus,train)
        self.delegate?.fetchData(busStation: bus, trainStation: train)
      case .Failure(_):
        completion([],[])
      }
    }
  }
  
  
  private func getTrainStation(station: Station) -> [TrainStationModel]{
    var stationName: String = ""
    let filteredStop = station.stops.filter{
      return $0.uri == Keys.finchStopKey.trainStop.rawValue
    }.compactMap{$0}
    
    guard let stops = filteredStop.first else{
      return []
    }
    
    var trainStationModel = [TrainStationModel]()
    
    for route in stops.routes {
      stationName = stops.name
      let stopTimes = route.stopTimes.map { (stopTime) -> StopTime in
        return StopTime(
          departureTime: stopTime.departureTime.appending("m"),
          shape: remove(stationName: stopTime.shape),
          departureTimestamp: stopTime.departureTimestamp,
          serviceID: stopTime.serviceID
        )
      }
      trainStationModel.append(TrainStationModel(name: stationName, stops: stopTimes))
    }
    
    return trainStationModel
  }
  
  
  private func getBusStation(station: Station) -> [BusStationModel]{
    var stationName: String = ""
    let filteredStop = station.stops.filter{
      return $0.uri == Keys.finchStopKey.busStop.rawValue
    }.compactMap{$0}
    
    guard let stops = filteredStop.first else{
      return []
    }
    
    var busStationModel = [BusStationModel]()
    
    for route in stops.routes {
      stationName = route.name
      let busStops = route.stopTimes.map { (stopTime) -> BusStops in
        return BusStops(
          busbay: getBusBay(title: stationName, stop: stopTime.shape) ?? "",
          shape: remove(stationName: stopTime.shape),
          departure: stopTime.departureTime.appending("m"))
      }
      busStationModel.append(BusStationModel(name: stationName, stops: busStops))
    }
    
    return busStationModel
  }
  
  
  /// Removes the station name on the string
  /// e.g. "60D Steeles West To Highway 27" to  "Highway 27"
  /// - Parameter stationName: name of the station
  /// - Returns: String
  private func remove(stationName: String) -> String {
    guard let range = stationName.range(of: " To ") else{
       return stationName
    }
    return String(stationName[range.upperBound...])
  }
  
  ///
  /// The letter represenstation of the terminal
  /// e.g. "60D Steeles West To Highway 27" get the  "D"
  /// - Parameters:
  ///   - title:name of station
  ///   - stop: name of th stop
  /// - Returns: Letter of the bus bas
  private func getBusBay(title: String, stop: String) -> String?{
    let diff = zip(title, stop).filter{$0 != $1 }.first
    return diff?.1.lowercased()
    
  }
  
}
