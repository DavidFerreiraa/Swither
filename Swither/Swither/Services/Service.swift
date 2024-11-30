//
//  Services.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import Foundation

struct ServiceError: Error {
    let message: String
}

extension Notification.Name {
    static let didChangeLoadingState = Notification.Name("didChangeLoadingState")
}

class Service {
    let apiKey: String
    private let baseUrl: String = "https://api.openweathermap.org/data/3.0/onecall"
    private let session = URLSession.shared
    
    init() {
        do {
            self.apiKey = try getApiKey()
        } catch {
            self.apiKey = ""
        }
    }
    
    func fetchDataByCurrentLocation(_ completion: @escaping (City?, OpenWeatherResponse?) -> Void) {
        LocationService.shared.getCityName { [weak self] city in
            
            guard let self = self else {return}
            
            guard let city = city else {
                print("City not found")
                completion(nil, nil)
                return
            }
            
            fetchData(city: city) { [weak self] data in
                guard let _ = self else {return}
                
                if let data = data {
                    completion(city, data)
                    return
                } else {
                    completion(nil, nil)
                    return
                }
            }
        }
    }
    
    
    func fetchData(city: City, _ completion: @escaping (OpenWeatherResponse?) -> Void) {
        let urlString: String = "\(baseUrl)?lat=\(city.lat)&lon=\(city.lon)&exclude=minutely,alerts&appid=\(apiKey)&units=metrics"
//        let urlString: String = ""
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let openWeatherResponse = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
                completion(openWeatherResponse)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        task.resume() //execute the task
    }
}

func getApiKey() throws -> String {
    guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
        throw ServiceError(message: "No such API key")
    }
    return apiKey
}
