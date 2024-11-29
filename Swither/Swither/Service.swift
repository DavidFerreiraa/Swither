//
//  Services.swift
//  Swither
//
//  Created by David Ferreira Lima on 26/11/24.
//

import Foundation

struct City {
    let lat: String
    let lon: String
    let name: String
}

struct ServiceError: Error {
    let message: String
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
    
    
    func fetchData(city: City, _ completion: @escaping (OpenWeatherResponse?) -> Void) {
        let urlString: String = "\(baseUrl)?lat=\(city.lat)&lon=\(city.lon)&exclude=minutely,alerts&appid=\(apiKey)"
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

// MARK: - OpenWeatherResponse
struct OpenWeatherResponse: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]?
    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt, precipitation: Double
}
