////
////  MapManager.swift
////  MyPlace
////
////  Created by Mitya Kim on 07.11.2020.
////
//
//import UIKit
//import MapKit
//
//class MapManager {
//    
//    let locationManager = CLLocationManager()
//    private var placeCoordinate: CLLocationCoordinate2D?
//    
//    private func setupPlaceMark(place: Place, mapView: MKMapView) {
//        
//        guard let location = place.location else { return }
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(location) { (placemarks, error) in
//            
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            guard let placemarcs = placemarks else { return }
//            
//            let placemark = placemarcs.first
//            let annotation = MKPointAnnotation()
//            annotation.title = place.name
//            annotation.subtitle = place.type
//            
//            
//            guard let placeMarkLocation = placemark?.location else { return }
//            annotation.coordinate = placeMarkLocation.coordinate
//            
//            self.placeCoordinate = placeMarkLocation.coordinate
//            
//            mapView.showAnnotations([annotation], animated: true)
//            mapView.selectAnnotation(annotation, animated: true)
//            
//        }
//    }
//    
//    private func checkLocationServices(mapView: MKMapView, segueIdentifier: String, closure: () -> ()) {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            closure()
//        } else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                showAlert(title: "Location are desable", message: "Hello")
//            }
//        }
//        
//    }
//    
//    private func setupMapView() {
//        
//        goButton.isHidden = true
//        
//        if incamSegueIdentifier == "showMap" {
//            setupPlaceMark()
//            mapPinImage.isHidden = true
//            addressLabel.isHidden = true
//            doneButton.isHidden = true
//            goButton.isHidden = false
//        }
//    }
//    
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    private func checLocationAutorization() {
//        
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
//            if incamSegueIdentifier == "getAdress"{ showUserLocation() }
//            break
//        case .denied:
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.showAlert(title: "Location are desable", message: "Hello")
//            }
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            break
//        case .authorizedAlways:
//            break
//        @unknown default:
//            print("Case is avalible!")
//        }
//    }
//    
//    private func showUserLocation() {
//        
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
//            mapView.setRegion(region, animated: true)
//        }
//    }
//    
//    private func startTrackingUserLocation() {
//        guard let previousLocation = previousLocation else { return }
//        let center = getCenterLocation(mapView)
//        guard center.distance(from: previousLocation) > 50 else { return }
//        self.previousLocation = center
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.showUserLocation()
//        }
//    }
//    
//    private func getDirection() {
//        
//        guard let location = locationManager.location?.coordinate else {
//            showAlert(title: "Error", message: "Error")
//            return
//        }
//        
//        locationManager.startUpdatingLocation()
//        previousLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
//        
//        guard let request = createDirectionRequest(from: location) else {
//            showAlert(title: "Error", message: "Error")
//            return
//        }
//        
//        let directions = MKDirections(request: request)
//        directions.calculate { (responce, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            guard let responce = responce else {
//                self.showAlert(title: "Error", message: "Error")
//                return
//            }
//            for route in responce.routes{
//                self.mapView.addOverlay(route.polyline)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//                
//                let distance = String(format: "%.1f", route.distance / 1000)
//                let timeInterval = route.expectedTravelTime
//                print(distance)
//                print(timeInterval)
//            }
//        }
//    }
//    
//    private func createDirectionRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request? {
//        
//        guard let destinationCoordinate = placeCoordinate else { return nil }
//        let startingLocation = MKPlacemark(coordinate: coordinate)
//        let destination = MKPlacemark(coordinate: coordinate)
//        
//        
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: startingLocation)
//        request.destination = MKMapItem(placemark: destination)
//        request.transportType = .walking
//        request.requestsAlternateRoutes = true
//        
//        return request
//    }
//    
//    private func getCenterLocation(_ sender: MKMapView) -> CLLocation {
//        
//        let latitude = mapView.centerCoordinate.latitude
//        let longitude = mapView.centerCoordinate.longitude
//        
//        return CLLocation(latitude: latitude, longitude: longitude)
//    }
//    
//}
//    
//    private func showAlert(title: String, message: String) {
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        
//        alert.addAction(okAction)
//        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
//        alertWindow.rootViewController = UIViewController()
//        alertWindow.windowLevel = UIWindow.Level.alert + 1
//        alertWindow.makeKeyAndVisible()
//        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    
//}
