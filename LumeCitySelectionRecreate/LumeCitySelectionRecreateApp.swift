//
//  LumeCitySelectionRecreateApp.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/16/25.
//

import SwiftUI

@main
struct LumeCitySelectionRecreateApp: App {
  
  @State var viewModel = WeatherViewModel(service: WeatherServiceWrapper(), cities: City.all)
  
  var body: some Scene {
    WindowGroup {
      WeatherView(viewModel: viewModel)
    }
  }
}
