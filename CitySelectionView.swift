//
//  CitySelectionView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/20/25.
//

import SwiftUI

struct CitySelectionView: View {
  
  let cities: [City]
  @Binding var selectedCity: City?
  @Namespace private var namespace
  
  var body: some View {
    VStack(alignment: .leading) {
      ForEach(cities) { city in
        HStack {
          ZStack {
            if selectedCity == city {
              Rectangle()
                .frame(width: 40, height: 1)
                .foregroundStyle(.white)
                .matchedGeometryEffect(id: "indicator", in: namespace)
            }
            
            Rectangle()
              .frame(width: 40, height: 1)
              .opacity(0)
          }
          
          Text(city.name)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
          
          Spacer()
        }
        .opacity(selectedCity == city ? 1 : 0.5)
        .onTapGesture {
          withAnimation(.snappy) {
            selectedCity = city
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  @Previewable @State var selectedCity = City.all.first
  CitySelectionView(cities: City.all, selectedCity: $selectedCity)
}
