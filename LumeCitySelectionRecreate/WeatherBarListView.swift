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
    self.symbolNames = items.map { $0.symbolName }
    self._selectedUnit = selectedUnit
  }
  
  @Binding var selectedUnit: UnitTemperature
  
  private let items: [WeatherItem]
  @State private var values: [Int]
  @State private var colors: [Color]
  @State private var symbolNames: [String]

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(Array(values.enumerated()), id: \.offset) { index, value in
          HStack {
            Rectangle()
              .containerRelativeFrame(.vertical, count: 24, span: 1, spacing: 0)
              .containerRelativeFrame(
                .horizontal,
                count: 120,
                span: value,
                spacing: 0
              )
              .foregroundStyle(colors[index])
              .overlay {
                LinearGradient(
                  colors: [.black.opacity(0.05), .clear],
                  startPoint: .top,
                  endPoint: .bottom
                )
              }
              .brightness(-Double(index - 23) * 0.01)

            Image(systemName: symbolNames[index])
              .symbolEffect(.bounce, value: symbolNames[index])
              .foregroundStyle(colors[index].gradient)
          }
          .task {
            await animate(at: index)
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      .background(.black, ignoresSafeAreaEdges: .all)
      .overlay {
        LinearGradient(
          colors: [.black.opacity(0.7), .clear],
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
    .onChange(of: selectedUnit) {
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
          values[l] = Int(items[l].temperature.converted(to: selectedUnit).value)
          colors[l] = items[l].temperatureColor
          symbolNames[l] = items[l].symbolName
        }
        
        if r <= items.count - 1 {
          values[r] = Int(items[r].temperature.converted(to: selectedUnit).value)
          colors[r] = items[r].temperatureColor
          symbolNames[r] = items[r].symbolName
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
