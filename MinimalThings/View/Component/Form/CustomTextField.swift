//
//  CustomTextField.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/25.
//

import SwiftUI

struct CustomTextField: View {
  let label: String
  @Binding var text: String
  
  var body: some View {
    TextField(label, text: $text)
      .padding(12)
      .background(.containerBackground)
      .frame(maxWidth: .infinity)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.containerDivider, lineWidth: 1)
      )
  }
}

#Preview {
  @Previewable @State var name: String = ""
  return CustomTextField(label: "name", text: $name)
}
