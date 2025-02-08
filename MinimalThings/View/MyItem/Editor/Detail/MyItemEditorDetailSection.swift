//
//  MyItemEditorDetailSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemEditorDetailSection: View {
  @FocusState.Binding var focused: Bool
  @Binding var brand: String
  @Binding var size: String
  
  @State private var isExpanded: Bool = false
  
    var body: some View {
      DisclosureGroup("詳細", isExpanded: $isExpanded) {
        
        VStack(spacing: 15) {
          VStack(alignment: .leading, spacing: 5) {
            Text("メーカー／ブランド")
              .font(.subheadline)
            TextField("例）無印良品、Apple", text: $brand)
              
              .focused($focused)
              .textFieldStyle(.roundedBorder)
          }          
          
          VStack(alignment: .leading, spacing: 5) {
            Text("サイズ")
              .font(.subheadline)
            TextField("例）Mサイズ、26.0cm", text: $size)
              .focused($focused)
              .textFieldStyle(.roundedBorder)
          }
        }
        .padding(.vertical)
      }
    }
}

#Preview {
    MyItemEditorDetailSection(
      focused: FocusState<Bool>().projectedValue,
      brand: .constant(""),
      size: .constant("")
    )
}
