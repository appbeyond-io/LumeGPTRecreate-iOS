//
//  WeatherBarListView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/16/25.
//

import SwiftUI

struct WeatherBarListView: View {
  
  init(items: [WeatherItem], selectedUnit: Binding<UnitTemperature>) {
    self.items = items
    self.values = Array(repeating: 0, count: items.count)
    self.colors = items.map { $0.temperatureColor }
    self._selectedUnit = selectedUnit
  }
  
  @Binding var selectedUnit: UnitTemperature
  
  private let items: [WeatherItem]
  @State private var values: [Int]
  @State private var colors: [Color]

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(Array(values.enumerated()), id: \.offset) { index, value in
          Rectangle()
            .containerRelativeFrame(.vertical, count: 24, span: 1, spacing: 0)
            .containerRelativeFrame(
              .horizontal,
              count: 60,
              span: value,
              spacing: 0
            )
            .foregroundStyle(colors[index].gradient)
            .task {
              await animate(at: index)
            }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      .background(.black, ignoresSafeAreaEdges: .all)
      .overlay {
        LinearGradient(
          colors: [.black.opacity(0.5), .black.opacity(0.5), .clear],
          startPoint: .top,
          endPoint: .bottom
        )
      }
    }
    .scrollDisabled(true)
    .ignoresSafeArea(.all)
    .onChange(of: items) {
      Task { @MainActor in
        await wave()
      }
    }
  }
  
  private func wave() async {
    let m = items.count / 2
    var l = m - 1
    var r = m
    
    while l >= 0 || r <= items.count - 1 {
      try? await Task.sleep(for: .seconds(abs(Double(r - m)) * 0.005))
      withAnimation(.spring(.bouncy(duration: 0.4, extraBounce: 0.2))) {
        if l >= 0 {
          values[l] = Int(items[l].temperature.value)
          colors[l] = items[l].temperatureColor
        }
        
        if r <= items.count - 1 {
          values[r] = Int(items[r].temperature.value)
          colors[r] = items[r].temperatureColor
        }
      }
      
      l -= 1
      r += 1
    }
  }
  
  private func animate(at index: Int) async {
    try? await Task.sleep(for: .seconds(Double(index) * 0.02))
    withAnimation(.spring(.bouncy(duration: 0.4, extraBounce: 0.2))) {
      values[index] = Int(items[index].temperature.value)
    }
  }
}

#Preview {
  WeatherBarListView(items: WeatherItem.bangkok, selectedUnit: .constant(.celsius))
}
