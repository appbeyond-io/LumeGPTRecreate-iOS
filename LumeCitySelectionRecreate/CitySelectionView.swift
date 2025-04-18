//
//  CitySelectionView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/17/25.
//

import SwiftUI
import CoreLocation

struct CitySelectionView: View {
  
  init(cities: [City], selectedCity: Binding<City>, selectedUnit: Binding<UnitTemperature>) {
    self.cities = cities
    self._selectedCity = selectedCity
    self._selectedUnit = selectedUnit
    self.animatedSelectedCity = selectedCity.wrappedValue
    self.animatedSelectedUnit = selectedUnit.wrappedValue
  }
  
  let cities: [City]
  
  @Binding var selectedCity: City
  @Binding var selectedUnit: UnitTemperature
  
  @State private var animatedSelectedCity: City
  @State private var animatedSelectedUnit: UnitTemperature
  @Namespace private var namespace
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 20) {
        Text(UnitTemperature.celsius.symbol)
          .opacity(animatedSelectedUnit == .celsius ? 1 : 0.5)
          .onTapGesture {
            selectedUnit = .celsius
            withAnimation(.snappy) {
              animatedSelectedUnit = .celsius
            }
          }

        Text(UnitTemperature.fahrenheit.symbol)
          .opacity(animatedSelectedUnit == .fahrenheit ? 1 : 0.5)
          .onTapGesture {
            selectedUnit = .fahrenheit
            withAnimation(.snappy) {
              animatedSelectedUnit = .fahrenheit
            }
          }
      }
      .font(.system(.title, weight: .semibold))
      .foregroundStyle(.white)
      .padding(20)
      
      Spacer()
      
      ForEach(cities) { city in
        HStack {
          ZStack {
            if animatedSelectedCity == city {
              Rectangle()
                .frame(width: 40, height: 1)
                .foregroundStyle(.white)
                .matchedGeometryEffect(id: "line", in: namespace, properties: .position)
            }
            
            Rectangle()
              .frame(width: 40, height: 1)
              .opacity(0)
          }
          
          Text(city.name)
            .font(.system(.title, weight: .semibold))
            .foregroundStyle(.white)
            .opacity(animatedSelectedCity == city ? 1 : 0.5)
          
          Spacer()
        }
        .onTapGesture {
          selectedCity = city
          withAnimation(.snappy) {
            animatedSelectedCity = city
          }
        }
      }
      
      Spacer()
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

extension City: Identifiable {
  var id: String { name }
}

#Preview {
  @Previewable @State var selectedCity = City(name: "New York", location: CLLocation(latitude: 40.7128, longitude: -74.0060))
  @Previewable @State var selectedUnit: UnitTemperature = .celsius
  
  let cities = [
    City(name: "New York", location: CLLocation(latitude: 40.7128, longitude: -74.0060)),
    City(name: "Tokyo", location: CLLocation(latitude: 35.6762, longitude: 139.6503)),
    City(name: "Paris", location: CLLocation(latitude: 48.8566, longitude: 2.3522)),
    City(name: "Bangkok", location: CLLocation(latitude: 13.7563, longitude: 100.5018)),
  ]

  CitySelectionView(
    cities: cities,
    selectedCity: $selectedCity,
    selectedUnit: $selectedUnit
  )
  .background(.black, ignoresSafeAreaEdges: .all)
}
