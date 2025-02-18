//
//  StylishArrow.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI

struct StylishArrow: View {
  let width: CGFloat
  let color: Color
  
  var body: some View {
    StylishArrowPath()
      .stroke(color, lineWidth: 1)
      .frame(width: width, height: 3)
  }
}

struct StylishArrowPath: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX - 3, y: rect.maxY - 3))
    
    return path
  }
}

#Preview {
  VStack {
    StylishArrow(width: 300, color: .foregroundTertiary)
  }
}
