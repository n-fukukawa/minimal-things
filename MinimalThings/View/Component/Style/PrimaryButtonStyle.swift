//
//  PrimaryButtonStyle.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.vertical, 12)
      .foregroundColor(.buttonForeground)
      .background(.buttonNormal)
      .cornerRadius(5)
  }
}

#Preview {
  Button("Button") {}
    .buttonStyle(PrimaryButtonStyle())
}
