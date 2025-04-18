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
  
  init(service: HourlyWeatherService, cities: [City]) {
    self.service = service
    self.cities = cities
    self.selectedCity = cities[0]
  }
  
  let service: HourlyWeatherService
  let cities: [City]
  var items: [WeatherItem] = []
  var selectedCity: City
  var selectedUnit: UnitTemperature = .fahrenheit
  
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
