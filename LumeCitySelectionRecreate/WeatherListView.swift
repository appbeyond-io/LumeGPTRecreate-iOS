//
//  WeatherListView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/20/25.
//

import SwiftUI

struct WeatherListView: View {
  
  @State private var selectedCity: City?
  
  var body: some View {
    ZStack {
      if let city = selectedCity {
        AnimatedBarsView(values: city.temperatures)
      }
      
      CitySelectionView(cities: City.all, selectedCity: $selectedCity)
    }
    .background(.black)
    .onAppear {
      selectedCity = City.all.first
    }
  }
}

#Preview {
  WeatherListView()
}
