//
//  WeatherItem.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/17/25.
//

import Foundation

struct WeatherItem: Hashable, Identifiable {
  let id: UUID
  let cityName: String
  let date: Date
  let symbolName: String
  let description: String
  let temperature: Measurement<UnitTemperature>
  let apparentTemperature: Measurement<UnitTemperature>
  let windSpeed: Measurement<UnitSpeed>
  let humidity: Double
}
