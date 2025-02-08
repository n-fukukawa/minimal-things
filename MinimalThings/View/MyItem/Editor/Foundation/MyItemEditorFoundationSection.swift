//
//  MyItemEditorFoundationSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import SwiftUI
import SwiftData

struct MyItemEditorFoundationSection: View {
  @Query private var categories: [ItemCategory]
  @Binding var name: String
  @Binding var category: ItemCategory?
  
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      VStack(alignment: .leading, spacing: 5) {
        Text("アイテム名")
          .font(.subheadline)
        TextField("", text: $name)
          .textFieldStyle(.roundedBorder)
      }
      
      VStack(alignment: .leading, spacing: 5) {
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
    }
  }
}

#Preview {
  MyItemEditorFoundationSection(
    name: .constant("name"),
    category: .constant(nil)
  )
}
