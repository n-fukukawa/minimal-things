//
//  WantedItemEditorFoundation.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI
import SwiftData

struct WantedItemEditorFoundation: View {
  @Query private var categories: [ItemCategory]
  @Binding var name: String
  @Binding var category: ItemCategory?
  @Binding var reasonWhyWant: String
  @FocusState.Binding var focused: Bool
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      VStack(alignment: .leading, spacing: 4) {
        Text("アイテム名")
          .font(.subheadline)
        TextField("", text: $name)
          .focused($focused)
          .textFieldStyle(.roundedBorder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("カテゴリ")
          .font(.subheadline)
        Picker("", selection: $category) {
          Text("選択してください").tag(nil as ItemCategory?)
          ForEach(categories) { category in
            Text(category.name).tag(category as ItemCategory?)
          }
        }
        .pickerStyle(.menu)
        
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("コメント")
          .font(.subheadline)
        TextEditor(text: $reasonWhyWant)
          .focused($focused)
          .multilineTextAlignment(.leading)
          .lineSpacing(4)
          .border(Color(UIColor.systemGray5), width: 1)
          .frame(height: 200)
      }
    }
  }
}

#Preview {
  WantedItemEditorFoundation(
    name: .constant("name"),
    category: .constant(nil),
    reasonWhyWant: .constant(""),
    focused: FocusState<Bool>().projectedValue
  )
}
