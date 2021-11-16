//
//  ViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 08.11.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    
    private var marker: GMSMarker?
    private var manualMarker: GMSMarker?
    private var locationManager: CLLocationManager?
    private let clDecoder = CLGeocoder()
    private let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureMap()
        configureCL()
        // Do any additional setup after loading the view.
    }
    
    private func configureMap() {
        let camera = GMSCameraPosition(target: coordinate, zoom: 17)
        mapView.camera = camera
    }
    
    private func configureCL() {
        locationManager = CLLocationManager()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }
    
    private func mark() {
        marker = GMSMarker(position: coordinate)
        marker?.map = mapView
    }
    private func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    
    @IBAction func goToCenter(_ sender: Any) {
        mapView.animate(toLocation: coordinate )
    }
    
    @IBAction func putMark(_ sender: Any) {
        marker != nil ? mark() : removeMarker()
    }
    
    @IBAction func updateLocation(_ sender: Any) {
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let coordinate =  locations.first?.coordinate else { return }
         let marker = GMSMarker()
         marker.position = coordinate
         marker.map = mapView
         mapView.animate(toLocation: marker.position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            manualMarker = marker
        }
    }
}
