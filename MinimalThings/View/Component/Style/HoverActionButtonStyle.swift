//
//  HoverActionButtonStyle.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/21.
//

import SwiftUI

struct HoverActionButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundStyle(.foregroundSecondary)
      .font(.system(size: 20))
      .frame(width: 36, height: 36)
      .background(
        Circle()
          .fill(Color.containerBackground.opacity(0.5))
      )
  }
}

#Preview {
  Button {} label: {
    Image(systemName: "ellipsis")
  }
  .buttonStyle(HoverActionButtonStyle())
  
  Button {} label: {
    Image(systemName: "xmark")
  }
  .buttonStyle(HoverActionButtonStyle())
}
