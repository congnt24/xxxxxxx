import Foundation
import GoogleMaps
import GooglePlaces

class GoogleMapHelper {
    static let ZoomLevel = 13.0
    private static var _instance: GoogleMapHelper? = nil
    
    static func instance() -> GoogleMapHelper? {
        return _instance
    }
    
    static func configure(){
        _instance = GoogleMapHelper()
        GMSServices.provideAPIKey("AIzaSyDu_PeEu7tF2W6S6fImWIKE9bgQqCz1reQ")
        GMSPlacesClient.provideAPIKey("AIzaSyAG4Jv-71U-1j8k9DTfKI5XjksHdC4ak4c")
    }
    
}
