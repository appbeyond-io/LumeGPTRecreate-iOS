//
//  WeatherItem+color.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/17/25.
//

import SwiftUI

extension WeatherItem {
  var temperatureColor: Color {
    let temp = temperature.value
    switch temp {
    case ..<15: return .blue
    case 15..<25: return .green
    default: return .orange
    }
  }
}
