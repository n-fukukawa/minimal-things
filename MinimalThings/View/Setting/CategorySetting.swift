//
//  CategorySetting.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/21.
//

import SwiftUI
import SwiftData

struct CategorySetting: View {
  @Environment(\.modelContext) var modelContext
  @Query(sort: \ItemCategory.sortOrder) var categories: [ItemCategory]
  
  @State private var isShowDeleteAlert: Bool = false
  @State private var deleteIndexes: IndexSet = []
  
  var body: some View {
    List {
      ForEach(categories) { category in
        NavigationLink {
          CategoryEditor(category: category)
        } label: {
          Text(category.name)
        }
      }
      .onMove(perform: moveRow)
      .onDelete(perform: showDeleteAlert)
    }
    .navigationTitle("カテゴリ")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItemGroup(placement: .topBarTrailing) {
        NavigationLink("追加") {
          CategoryEditor()
        }
        EditButton()
      }
    }
    .alert(isPresented: $isShowDeleteAlert) {
      Alert(
        title: Text("削除しますか？"),
        message: Text("削除するカテゴリに含まれるアイテムは未分類に移動されます"),
        primaryButton: Alert.Button.destructive(Text("削除")) {
          deleteRow()
        },
        secondaryButton: Alert.Button.default(Text("キャンセル")) {
          deleteIndexes = []
          isShowDeleteAlert = false
        }
      )
    }
  }
  
  private func showDeleteAlert(indexes: IndexSet) {
    deleteIndexes = indexes
    isShowDeleteAlert = true
  }
  
  private func moveRow(from source: IndexSet, to destination: Int) {
    var newCategories = categories
    newCategories.move(fromOffsets: source, toOffset: destination)
    for (index, category) in newCategories.enumerated() {
      category.sortOrder = index + 1
    }
  }
  
  private func deleteRow() {
    for index in deleteIndexes {
      modelContext.delete(categories[index])
    }
    deleteIndexes = []
    isShowDeleteAlert = false
  }
}

#Preview {
  NavigationStack {
    CategorySetting()
      .modelContainer(PreviewModelContainer.container)
  }
}
