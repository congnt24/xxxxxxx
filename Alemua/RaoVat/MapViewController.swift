//
//  MapViewController.swift
//  CheckIniOS
//
//  Created by Cong Nguyen on 8/10/17.
//  Copyright © 2017 Cong Nguyen. All rights reserved.
//


import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    let ZOOM: Float = 14.0
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    let geocoder = GMSGeocoder()
    var curLocation: CLLocation?
    var movingCamera = GMSCameraPosition.camera(withLatitude: 21.005, longitude: 105.811, zoom: 14.0)
    var centerMarker = GMSMarker()
    var centerAddress = ""

    var onMovingMap: ((String?, CLLocationCoordinate2D?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        //setting delegate and request permission for current location
        locationManager.delegate = self

        placesClient = GMSPlacesClient.shared()
        //setup current location

        mapView = GMSMapView.map(withFrame: view.bounds, camera: movingCamera)
        mapView.mapType = .normal
        mapView.accessibilityElementsHidden = false
        //mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true // show blue bubble for current location
        mapView.settings.compassButton = true
        mapView.settings.indoorPicker = true
        //        mapView.settings.scrollGestures = false
        //        mapView.settings.zoomGestures = false
        // Add the map to the view, hide it until we've got a location update.
        mapView.delegate = self
        view.addSubview(mapView)
    }


    func searchlocation(locSearch: String) {
        CLGeocoder().geocodeAddressString(locSearch, completionHandler: { placemark, error in
            if error == nil {
                if let location = placemark?.first?.location?.coordinate {

                    let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                          longitude: location.longitude,
                                                          zoom: self.ZOOM)
                    self.mapView.animate(to: camera)
                }
            } else {
                print(error.debugDescription)
            }
        })
    }

    func moveToPosition(lat: Float, long: Float) {
        movingCamera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long), zoom: ZOOM)
    }
}


extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        let infoMarker = GMSMarker()
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        //make infomarker transparent
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //        marker.position = position.target
    }

    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        if let onMovingMap = onMovingMap {
            geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
                guard error == nil else {
                    return
                }

                if let result = response?.firstResult() {
                    self.centerMarker.position = cameraPosition.target
                    self.centerMarker.title = result.lines?[0]
                    self.centerMarker.snippet = result.lines?[1]
                    self.centerAddress = result.lines?[0] ?? ""
                    self.centerMarker.map = mapView
                    onMovingMap(result.lines?[0], cameraPosition.target)
                }
            }
        }
    }

}
//MARK: Moving camera
//MARK: Add marker
extension MapViewController {

    func movingCameraToLocation(lat: Float, lon: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon), zoom: ZOOM)
        mapView.animate(to: camera)
    }

    func addMarkerToLocation(lat: Float, lon: Float, image: UIImage?) {
        var marker = GMSMarker()
        let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        marker = GMSMarker(position: position)
        marker.icon = image
        marker.isFlat = true
        marker.map = mapView
    }

    func addMarkerToCurrentLocation(image: UIImage) {
        if let curLocation = curLocation {
            var marker = GMSMarker()
            print(curLocation)
            let position = CLLocationCoordinate2D(latitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude)
            marker = GMSMarker(position: position)
            marker.icon = image
            //            marker.
            marker.isFlat = true
            //            marker.rotation = 45
            marker.map = mapView
        }
    }
    func addMarkerToCurrentLocation(view: UIView) {
        if let curLocation = curLocation {
            var marker = GMSMarker()
            print(curLocation)
            let position = CLLocationCoordinate2D(latitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude)
            marker = GMSMarker(position: position)
            marker.iconView = view
            //            marker.
            marker.isFlat = true
            //            marker.rotation = 45
            marker.map = mapView
        }
    }


    func addCircleToLocation(location: CLLocation) {

    }
    func addCircleToLocation(lat: Float, lon: Float, radius: Float) {
        let circleCenter = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        let circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(radius))

        circ.fillColor = UIColor.init(hexString: "#4CC3D9", transparency: 0.3)
        circ.strokeColor = UIColor.init(hexString: "#4CC3D9")
        circ.strokeWidth = 1
        circ.map = mapView
    }
}

extension MapViewController: CLLocationManagerDelegate {


    func getPlace() {

        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(CLLocation(latitude: 21, longitude: 105.81)) { (place, error) in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            //            if let placeLikelihoodList = placeLikelihoodList {
            //                let place = placeLikelihoodList.likelihoods.first?.place
            if let p = place {
                //                    self.nameLabel.text = place.name
                //                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                //                        .joined(separator: "\n")
                //                    HomeViewController.shared.currentAddress = place.formattedAddress ?? ""
                print(p[0].name)
            }
            //            }
        }
    }
    func getCurrentPlace() {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }

            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {

                }
            }
        })
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        self.curLocation = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: ZOOM)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
