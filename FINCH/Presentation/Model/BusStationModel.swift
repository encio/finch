//
//  BusStationModel.swift
//  FINCH
//
//  Created by Peter Encio on 6/20/21.
//

import Foundation


class BusStationModel {
  var name: String
  var stops = [BusStops]()
  
  init(name: String, stops: [BusStops]){
    self.name = name
    self.stops = stops
  }
}

struct BusStops{
  var busbay: String
  var shape: String
  var departure: String
}
