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
