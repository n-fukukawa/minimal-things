//
//  MyItemEditorFoundationSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import SwiftUI

struct MyItemEditorFoundationSection: View {
  @Binding var name: String

    var body: some View {
      
      VStack(alignment: .leading, spacing: 5) {
        Text("アイテム名")
          .font(.subheadline)
        TextField("", text: $name)
          .textFieldStyle(.roundedBorder)
      }
    }
}

#Preview {
  MyItemEditorFoundationSection(name: .constant("name"))
}
