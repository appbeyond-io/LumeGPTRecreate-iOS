//
//  WeatherServiceWrapper.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/18/25.
//

import Foundation
import WeatherKit

class WeatherServiceWrapper: HourlyWeatherService {
  
  let weatherService: WeatherService = .shared
  
  func fetchHourlyWeather(for city: City) async -> [WeatherItem] {
    guard let forecast = try? await weatherService.weather(for: city.location, including: .hourly) else {
      return []
    }
    
    let items: [WeatherItem] = forecast.forecast.map { weather in
      return WeatherItem(
        id: UUID(),
        cityName: city.name,
        date: weather.date,
        symbolName: weather.symbolName,
        description: weather.condition.description,
        temperature: weather.temperature,
        apparentTemperature: weather.apparentTemperature,
        windSpeed: weather.wind.speed,
        humidity: weather.humidity
      )
    }
    
    return items
  }
}
