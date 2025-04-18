//
//  AnimatedBarView.swift
//  LumeCitySelectionRecreate
//
//  Created by Yossa Bourne on 4/16/25.
//

import SwiftUI

struct AnimatedBarView: View {
  
  @State var states: [Bool] = Array(repeating: false, count: 25)
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(Array(states.enumerated()), id: \.offset) { index, _ in
        Rectangle()
          .frame(height: 40)
          .frame(width: states[index] ? 50 + 15 * CGFloat(index) : 0)
          .foregroundStyle(.blue.gradient)
          .hueRotation(.degrees(Double(index * 10)))
          .task {
            try? await Task.sleep(for: .seconds(Double(index) * 0.02))
            withAnimation(.spring(.bouncy(duration: 0.4, extraBounce: Double(index) * 0.002))) {
              states[index] = true
            }
          }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  AnimatedBarView()
}
