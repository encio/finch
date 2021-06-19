//
//  TrainStationModel.swift
//  FINCH
//
//  Created by Peter Encio on 6/20/21.
//

import Foundation


class TrainStationModel {
  var name: String
  var stops = [StopTime]()
  
  init(name: String, stops: [StopTime]){
    self.name = name
    self.stops = stops
  }
}
