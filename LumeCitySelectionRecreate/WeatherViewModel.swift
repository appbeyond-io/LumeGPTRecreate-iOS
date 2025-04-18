//
//  WeatherViewModel.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/18/25.
//

import Foundation
import CoreLocation

@Observable
class WeatherViewModel {
  
  init(service: HourlyWeatherService) {
    self.service = service
    self.cities = [
      City(name: "New York", location: CLLocation(latitude: 40.7128, longitude: -74.0060)),
      City(name: "Tokyo", location: CLLocation(latitude: 35.6762, longitude: 139.6503)),
      City(name: "Paris", location: CLLocation(latitude: 48.8566, longitude: 2.3522)),
      City(name: "Bangkok", location: CLLocation(latitude: 13.7563, longitude: 100.5018)),
    ]
    
    self.selectedCity = cities[0]
  }
  
  let service: HourlyWeatherService
  let cities: [City]
  var items: [WeatherItem] = []
  var selectedCity: City
  var selectedUnit: UnitTemperature = .celsius
  
  @MainActor
  func onAppear() async {
    await fetchWeather(for: selectedCity)
  }
  
  @MainActor
  func fetchWeather(for city: City) async {
    items = await service.fetchHourlyWeather(for: city)
  }
}

protocol HourlyWeatherService {
  func fetchHourlyWeather(for city: City) async -> [WeatherItem]
}
