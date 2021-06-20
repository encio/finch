//
//  DetailsViewController.swift
//  FINCH
//
//  Created by Peter Encio on 6/19/21.
//

import UIKit
import MapKit
final class DetailsViewController: BaseViewController {
  
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var stationLabel: UILabel!
  var coordinator: DetailsCoordinator?
  var searchLocation: String = ""
  @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupStationLabel(isLoading: true)
    setupMap()
    getCoordinate(search: "\(searchLocation) station, Ontario, Canada")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    coordinator?.didFinish(coordinator: self.coordinator!)
  }
  
  private func setupStationLabel(isLoading: Bool){
    if isLoading{stationLabel.text = "Calculating Route..."}
    else{stationLabel.text = "Finch Station to \(searchLocation) Station"}
    
  }
  private func getCoordinate(search: String){
    var coordinate: CLLocationCoordinate2D?
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = search
    let search = MKLocalSearch(request: searchRequest)
    search.start { [self] response, error in
      guard let response = response else {
        print("Error: \(error?.localizedDescription ?? "Unknown error").")
        return
      }
      
      guard let found = response.mapItems.first?.placemark else {
        return
      }
      
      coordinate = CLLocationCoordinate2D(latitude: found.coordinate.latitude, longitude: found.coordinate.longitude)
      
      guard let coordinate = coordinate else {
        return
      }
      
      //      let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
      //      mapView.setRegion(region, animated: true)
      //
      showRouteOnMap(pickupCoordinate: finchCoordinate, destinationCoordinate: coordinate)
      
    }
  }
  
  @IBAction func exit(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  private func setupMap(){
    mapView.delegate = self
    mapView.mapType = MKMapType.mutedStandard
    mapView.isZoomEnabled = true
    mapView.showsCompass = true
    mapView.showsScale = true
    mapView.showsTraffic = true
    mapView.isScrollEnabled = true
  }
  
  func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
    
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
    request.requestsAlternateRoutes = true
    request.transportType = .automobile
    
    let directions = MKDirections(request: request)
    backButton.isUserInteractionEnabled = false
    directions.calculate { [unowned self] response, error in
      guard let unwrappedResponse = response else { return }
      backButton.isUserInteractionEnabled = true
      
      //for getting just one route
      if let route = unwrappedResponse.routes.first {
        setupStationLabel(isLoading: false)
        //show on map
        self.mapView.addOverlay(route.polyline)
        //set the map area to show the route
        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
      }
    }
  }
  private let finchCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(43.7808), longitude: CLLocationDegrees(-79.4153))
  
}

extension DetailsViewController:MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(overlay: overlay)
    renderer.strokeColor = UIColor.red
    renderer.lineWidth = 5.0
    return renderer
  }
}
