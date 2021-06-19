//
//  StationModel.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let station = try? newJSONDecoder().decode(Station.self, from: jsonData)

import Foundation

// MARK: - Station
class Station: Codable {
  let time: Int
  let stops: [Stop]
  let uri, name: String
  

  
  
  init(time: Int, stops: [Stop], uri: String, name: String) {
    self.time = time
    self.stops = stops
    self.uri = uri
    self.name = name
  }
}

// MARK: - Stop
class Stop: Codable {
  let name, uri: String
  let routes: [Route]
  let agency: Agency
  
  init(name: String, uri: String, routes: [Route], agency: Agency) {
    self.name = name
    self.uri = uri
    self.routes = routes
    self.agency = agency
  }
}

enum Agency: String, Codable {
  case torontoTransitCommission = "Toronto Transit Commission"
}

// MARK: - Route
class Route: Codable {
  let name, uri: String
  let stopTimes: [StopTime]
  let routeGroupID: String
  
  enum CodingKeys: String, CodingKey {
    case name, uri
    case stopTimes = "stop_times"
    case routeGroupID = "route_group_id"
  }
  
  init(name: String, uri: String, stopTimes: [StopTime], routeGroupID: String) {
    self.name = name
    self.uri = uri
    self.stopTimes = stopTimes
    self.routeGroupID = routeGroupID
  }
}

// MARK: - StopTime
class StopTime: Codable {
  let departureTime, shape: String
  let departureTimestamp, serviceID: Int
  
  enum CodingKeys: String, CodingKey {
    case departureTime = "departure_time"
    case shape
    case departureTimestamp = "departure_timestamp"
    case serviceID = "service_id"
  }
  
  init(departureTime: String, shape: String, departureTimestamp: Int, serviceID: Int) {
    self.departureTime = departureTime
    self.shape = shape
    self.departureTimestamp = departureTimestamp
    self.serviceID = serviceID
  }
}
