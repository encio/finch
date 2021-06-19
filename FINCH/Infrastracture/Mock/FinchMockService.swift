//
//  FinchMockService.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation


final class MockHelper{
  
  static func loadJson() -> Station? {
      if let url = Bundle.main.url(forResource: "finch", withExtension: "json") {
          do {
              let data = try Data(contentsOf: url)
              let jsonData = try JSONDecoder().decode(Station.self, from: data)
              return jsonData
          } catch {
              print("error:\(error)")
          }
      }
      return nil
  }
}

final class FinchMockServiceFailed: DumbGetterServiceProtocol{
  func get(completionHandler: @escaping(Result<Station>) -> Void) {
    completionHandler(.Failure("error"))
  }
}

final class FinchMockBusOnly: DumbGetterServiceProtocol{
  func get(completionHandler: @escaping(Result<Station>) -> Void) {
    guard let json = MockHelper.loadJson() else{
      return
        completionHandler(.Failure(""))
    }
    let busStop = json.stops.filter { (stop) -> Bool in
      stop.uri == "finch_station_bus_bay"
    }
    json.stops.removeAll()
    json.stops = busStop
    completionHandler(.Success(json))
  }
}

final class FinchMockTrainOnly: DumbGetterServiceProtocol{
  func get(completionHandler: @escaping(Result<Station>) -> Void) {
    guard let json = MockHelper.loadJson() else{
      return
        completionHandler(.Failure(""))
    }
    let trainStop = json.stops.filter { (stop) -> Bool in
      stop.uri == "finch_station_subway_platform"
    }
    json.stops.removeAll()
    json.stops = trainStop
    completionHandler(.Success(json))
  }
}
