//
//  AnimatedBarsView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/20/25.
//

import SwiftUI

struct AnimatedBarsView: View {
  
  init(values: [Double]) {
    self.values = values
    self.animatedValues = Array(repeating: 0, count: 24)
  }
  
  let values: [Double]
  @State private var animatedValues: [Double]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(Array(values.enumerated()), id: \.offset) { index, value in
          Rectangle()
            .containerRelativeFrame(.vertical, count: 24, span: 1, spacing: 0)
            .containerRelativeFrame(
              .horizontal,
              count: 1000,
              span: Int(animatedValues[index] * 10),
              spacing: 0
            )
            .foregroundStyle(value.temperatureColor.gradient)
            .brightness(-Double(index - 23) * 0.01)
            .task {
              try? await Task.sleep(for: .seconds(0.5 + Double(index) * 0.02))
              withAnimation(.spring(.bouncy(duration: 0.4, extraBounce: 0.2))) {
                animatedValues[index] = value
              }
            }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .overlay {
        LinearGradient(
          colors: [.black.opacity(0.7), .clear],
          startPoint: .top,
          endPoint: .bottom
        )
      }
    }
    .scrollDisabled(true)
    .ignoresSafeArea()
    .onChange(of: values) {
      Task { @MainActor in
        let m = values.count / 2
        var l = m - 1
        var r = m
        
        while l >= 0 || r <= values.count - 1 {
          try? await Task.sleep(for: .seconds(abs(Double(r - m)) * 0.005))
          withAnimation(.spring(.bouncy(duration: 0.4, extraBounce: 0.2))) {
            if l >= 0 {
              animatedValues[l] = values[l]
            }
            
            if r <= values.count - 1 {
              animatedValues[r] = values[r]
            }
          }
          
          l -= 1
          r += 1
        }
      }
    }
  }
}

#Preview {
  AnimatedBarsView(values: City.all.first!.temperatures)
}
