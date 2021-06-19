//
//  StationService.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation


class StationService: DumbGetterServiceProtocol{
  typealias Data = Station
  
  func get(completionHandler: @escaping(Result<Station>) -> Void) {
    let url = URL(string: "https://myttc.ca/finch_station.json")!
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      guard let data = data else { return }
      do{
        let station = try JSONDecoder().decode(Station.self, from: data)
        completionHandler(.Success(station))
      } catch {
        completionHandler(.Failure(error.localizedDescription))
      }
      
      
      //      print(station.stops.first?.name)
    }
    
    task.resume()
  }
  
  
  
}
