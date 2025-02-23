//
//  CategoryEditor.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI

struct CategoryEditor: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  let category: ItemCategory?
  @State private var name: String
  @FocusState var isFocused: Bool
  
  init(category: ItemCategory? = nil) {
    self.category = category
    if let defaultName = category?.name {
      name = defaultName
    } else {
      name = ""
    }
  }
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.backgroundPrimary)
        .ignoresSafeArea()
      
      VStack(spacing: 30) {
        TextField("カテゴリ名", text: $name)
          .focused($isFocused)
          .padding(12)
          .background(.containerBackground)
          .frame(maxWidth: .infinity)
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(.containerDivider, lineWidth: 1)
          )
        Button(category == nil ? "作成" : "上書き保存") { onSave() }
          .buttonStyle(PrimaryButtonStyle())
        Spacer()
      }
      .padding(30)
      .navigationTitle(category == nil ? "カテゴリ作成" : "カテゴリ編集")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .keyboard) {
          HStack {
            Spacer()
            Button("閉じる") {
              isFocused = false
            }
          }
        }
      }
      .onAppear {
        isFocused = true
      }
    }
  }
  
  private func onSave() {
    if let _category = category {
      // 更新
      _category.name = name
    } else {
      // 作成
      let newCategory = ItemCategory(name: name)
      modelContext.insert(newCategory)
    }
    dismiss()
  }
}

#Preview {
  CategoryEditor()
    .modelContainer(PreviewModelContainer.container)
}
