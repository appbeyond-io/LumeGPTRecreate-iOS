//
//  City.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/18/25.
//

import CoreLocation

struct City: Hashable {
  let name: String
  let location: CLLocation
  
  static func == (lhs: City, rhs: City) -> Bool {
    lhs.name == rhs.name
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}

extension City {
  static var all: [City] = [
    City(name: "New York", location: CLLocation(latitude: 40.7128, longitude: -74.0060)),
    City(name: "Tokyo", location: CLLocation(latitude: 35.6762, longitude: 139.6503)),
    City(name: "Paris", location: CLLocation(latitude: 48.8566, longitude: 2.3522)),
    City(name: "Bangkok", location: CLLocation(latitude: 13.7563, longitude: 100.5018)),
    City(name: "Singapore", location: CLLocation(latitude: 1.3521, longitude: 103.8198)),
  ]
}
