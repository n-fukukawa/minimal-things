//
//  StylishArrowBack.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI

struct StylishArrowBack: View {
  let width: CGFloat
  let color: Color
  
  var body: some View {
    StylishArrowBackPath()
      .stroke(color, lineWidth: 1)
      .frame(width: width, height: 10)
  }
}

struct StylishArrowBackPath: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX + 10, y: rect.maxY - 10))
    
    return path
  }
}

#Preview {
  VStack {
    StylishArrowBack(width: 300, color: .foregroundTertiary)
  }
}
