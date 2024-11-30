//
//  WeatherViewModel.swift
//  Swither
//
//  Created by David Ferreira Lima on 30/11/24.
//

import Foundation

class WeatherViewModel {
    private let service = Service()
    var cityName: String = ""
    var temperature: String = ""
    var humidity: String = ""
    var wind: String = ""
    var hourlyForecast: [Current] = []
    var dailyForecast: [Daily] = []
    
    var isLoading: Bool = true {
        didSet {
            NotificationCenter.default.post(name: .didChangeLoadingState, object: nil)
        }
    }
    
    func fetchWeatherData(completion: @escaping (String?) -> Void) {
        isLoading = true
        service.fetchDataByCurrentLocation { [weak self] city, response in
            guard let self else { return }
            
            if let city = city, let response = response {
                self.cityName = city.name
                self.temperature = response.current.temp.tempToString()
                self.humidity = response.current.humidity.humidityToString()
                self.wind = response.current.windSpeed.windSpeedToString()
                self.hourlyForecast = response.hourly
                self.dailyForecast = response.daily
                self.isLoading = false
                completion(nil)
            } else {
                completion("Error fetching data")
            }
        }
    }
}
