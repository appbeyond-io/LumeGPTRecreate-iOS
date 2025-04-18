//
//  WeatherView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/18/25.
//

import SwiftUI

struct WeatherView: View {
  
  @State var viewModel: WeatherViewModel
  
  var body: some View {
    ZStack {
      if !viewModel.items.isEmpty {
        WeatherBarListView(items: viewModel.items, selectedUnit: $viewModel.selectedUnit)
      }
      
      CitySelectionView(
        cities: viewModel.cities,
        selectedCity: $viewModel.selectedCity,
        selectedUnit: $viewModel.selectedUnit
      )
    }
    .task {
      await viewModel.onAppear()
    }
    .onChange(of: viewModel.selectedCity) {
      Task { @MainActor in
        await viewModel.fetchWeather(for: viewModel.selectedCity)
      }
    }
  }
}

#Preview {
  @Previewable @State var viewModel = WeatherViewModel(service: WeatherServiceWrapper())
  WeatherView(viewModel: viewModel)
}
