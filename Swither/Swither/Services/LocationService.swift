//
//  LocationService.swift
//  Swither
//
//  Created by David Ferreira Lima on 28/11/24.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    private var locationCompletion: ((CLLocation) -> Void)?
    
    private var location: CLLocation? {
        didSet {
            guard let location else {
                return
            }
            
            locationCompletion?(location)
        }
    }
    
    static let shared = LocationService()
    
    public func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        
        self.locationCompletion = completion
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    //MARK: Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
        manager.stopUpdatingLocation()
    }
    
    public func getCityName(completion: @escaping (City?) -> Void) {
        getCurrentLocation { location in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Error in reverse geocoding: \(error)")
                    completion(nil)
                    return
                }
                
                if let placemark = placemarks?.first {
                    //get the city name
                    if let cityName = placemark.locality {
                        let city = City(lat: location.coordinate.latitude.formatted(), lon: location.coordinate.longitude.formatted(), name: String(cityName))
                        completion(city)
                        return
                    }
                    completion(nil)
                }
            }
        }
    }
}
