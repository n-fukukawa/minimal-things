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
    .background(.backgroundPrimary)
    .scrollContentBackground(.hidden)
    .navigationTitle("Category")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItemGroup(placement: .topBarTrailing) {
        NavigationLink("Add") {
          CategoryEditor()
        }
        EditButton()
      }
    }
    .alert(isPresented: $isShowDeleteAlert) {
      Alert(
        title: Text("Do you want to delete it?"),
        message: Text("Items in the category to be deleted will be moved to Uncategorized。."),
        primaryButton: Alert.Button.destructive(Text("Delete")) {
          deleteRow()
        },
        secondaryButton: Alert.Button.default(Text("Cancel")) {
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
