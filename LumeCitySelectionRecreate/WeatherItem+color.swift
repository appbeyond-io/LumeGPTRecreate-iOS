//
//  WeatherItem+color.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/17/25.
//

import SwiftUI

extension Color {
//  static let coldBlue = Color(red: 161 / 255.0, green: 227 / 255.0, blue: 249 / 255.0)
  static let coldBlue = Color(red: 64 / 255.0, green: 248 / 255.0, blue: 255 / 255.0)
  static let comfortMint = Color(red: 109 / 255.0, green: 225 / 255.0, blue: 210 / 255.0)
//  static let comfortGreen = Color(red: 182 / 255.0, green: 255 / 255.0, blue: 161 / 255.0)
  static let comfortGreen = Color(red: 0 / 255.0, green: 255 / 255.0, blue: 156 / 255.0)
  static let warmYellow = Color(red: 255 / 255.0, green: 186 / 255.0, blue: 23 / 255.0)
//  static let warmYellow = Color(red: 255 / 255.0, green: 235 / 255.0, blue: 0 / 255.0)
//  static let warmYellow = Color(red: 255 / 255.0, green: 214 / 255.0, blue: 58 / 255.0)
  static let hotOrange = Color(red: 255 / 255.0, green: 145 / 255.0, blue: 73 / 255.0)
//  static let hotOrange = Color(red: 255 / 255.0, green: 169 / 255.0, blue: 85 / 255.0)
  static let hotOrange2 = Color(red: 234 / 255.0, green: 115 / 255.0, blue: 0 / 255.0)
//  static let hotOrange2 = Color(red: 255 / 255.0, green: 155 / 255.0, blue: 23 / 255.0)
  static let hellRed = Color(red: 247 / 255.0, green: 90 / 255.0, blue: 90 / 255.0)
}

extension WeatherItem {
  var temperatureColor: Color {
    let temp = temperature.converted(to: .celsius).value
    switch temp {
    case ..<15: return .coldBlue
    case 15..<20: return .comfortGreen
    case 20..<25: return .comfortGreen
//    case 20..<25: return .comfortGreen
    case 25..<30: return .warmYellow
//    case 25..<30: return .hotOrange
//    case 30..<35: return .hotOrange2
    case 30..<35: return .hotOrange
    case 35..<40: return .hotOrange2
    default: return .hellRed
    }
  }
}
