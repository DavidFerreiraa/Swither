//
//  Core+Extensions.swift
//  Swither
//
//  Created by David Ferreira Lima on 29/11/24.
//

import Foundation

extension Int {
    func toWeekDayName() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE" //Full weekday name
        
        return dateFormatter.string(from: date)
    }
    
    func toHourFormat() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" //24hr format
        
        return dateFormatter.string(from: date)
    }
    
    func isDayTime() -> Bool {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let hour = Calendar.current.component(.hour, from: date)
        
        let dayStartHour = 6
        let dayEndHour = 18
        
        return hour >= dayStartHour && hour < dayEndHour
    }
    
    func humidityToString() -> String {
        let actualHumidity = self
        return "\(actualHumidity)mm"
    }
}

extension Double {
    func tempToString() -> String {
        let tempInDouble = self
        let temperatureString = String(Int(tempInDouble)) // Convert to string
        let firstTwoCharacters = String(temperatureString.prefix(2)) // Get first two characters
        return "\(firstTwoCharacters)ºC"
    }
    
    func windSpeedToString() -> String {
        let actualWindSpeed = self
        
        return "\(actualWindSpeed)Km/h"
    }
}
