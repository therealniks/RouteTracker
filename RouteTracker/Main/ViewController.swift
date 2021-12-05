//
//  ViewController.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 08.11.2021.
//

import UIKit
import GoogleMaps
import RealmSwift

class ViewController: UIViewController {
    
    private var locationManager: CLLocationManager?
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var marker: GMSMarker?
    private var isTracking: Bool = false

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var startTrackingButton: UIBarButtonItem!
    @IBOutlet weak var finishTrackingButton: UIBarButtonItem!
    @IBOutlet weak var showRoute: UIBarButtonItem!
    
    @IBAction func startTracking(_ sender: UIBarButtonItem?) {
        
        toggleButtons()
        
        isTracking = true
        
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView

        locationManager?.startUpdatingLocation()
        locationManager?.startMonitoringSignificantLocationChanges()

        let zoomCamera = GMSCameraUpdate.zoom(to: 17)
        mapView.animate(with: zoomCamera)
    }
    
    @IBAction func finishTracking(_ sender: UIBarButtonItem?) {
        
        toggleButtons()
        
        isTracking = false
        locationManager?.stopUpdatingLocation()
        locationManager?.stopMonitoringSignificantLocationChanges()
        saveToDB(path: routePath)
    }
    
    @IBAction func showRoute(_ sender: UIBarButtonItem) {
        
        guard !isTracking else {
            let alert = UIAlertController(title: "Error", message: "Route not complete", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "OK", style: .cancel)
            let actionFinish = UIAlertAction(title: "Finish", style: .default) { [weak self] _ in
                self?.finishTracking(nil)
                self?.startTracking(nil)
            }
            alert.addAction(actionCancel)
            alert.addAction(actionFinish)
            present(alert, animated: true)
            return
        }
        
        guard let routePath = loadFromDB()
        else {
            let alert = UIAlertController(title: "Error", message: "Not saved route", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        route?.map = nil
        route = GMSPolyline()
        route?.map = mapView
        route?.path = routePath
        let bounds = GMSCoordinateBounds(path: routePath)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 10.0)
        mapView.moveCamera(update)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLM()
        configureMap()
        // Do any additional setup after loading the view.
    }
    
    private func toggleButtons() {
        startTrackingButton.isEnabled.toggle()
        finishTrackingButton.isEnabled.toggle()
    }
    
    
    private func configureMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 0.01, longitude: 0.01, zoom: 17.0)
        mapView.camera = camera
        marker = GMSMarker()
        marker?.map = mapView
    }
    
    private func configureLM() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.requestAlwaysAuthorization()
    }
}
extension ViewController: CLLocationManagerDelegate {
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let coordinate =  locations.first?.coordinate else { return }
         marker?.position = coordinate
         routePath?.add(coordinate)
         route?.path = routePath
         mapView.animate(toLocation: coordinate)
         print(coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController {
    
    func convertToPoints(from path: GMSMutablePath) -> [Point] {
        var result = [Point]()
        for i in 0..<path.count() {
            let point = Point()
            point.latitude = path.coordinate(at: i).latitude
            point.longitude = path.coordinate(at: i).longitude
            result.append(point)
        }
        return result
    }
    
    func convertToPath(from points: [Point]) -> GMSMutablePath {
        let result = GMSMutablePath()
        points.forEach {
            result.add(CLLocationCoordinate2D(latitude: $0.latitude,
                                              longitude: $0.longitude))
        }
        return result
    }
    
    func saveToDB(path: GMSMutablePath?) {
        guard let path = path else { return }
        
        do {
            let realm = try Realm()
            print(String(describing: realm.configuration.fileURL))
            try realm.write {
                realm.deleteAll()
                
                let points = convertToPoints(from: path)
                realm.add(points)
            }
        } catch {
            print(error)
        }
    }
    
    func loadFromDB() -> GMSMutablePath? {
        do {
            let realm = try Realm()
            let points = Array(realm.objects(Point.self))
            if points.count == 0  { return nil }
            let path = convertToPath(from: points)
            return path
        } catch {
            print(error)
            return nil
        }
    }
}
