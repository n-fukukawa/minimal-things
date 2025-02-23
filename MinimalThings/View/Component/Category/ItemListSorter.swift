//
//  ItemListSorter.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI
import SwiftData

struct ItemListSorter: View {
  @Environment(\.editMode) var editMode
  @Environment(\.modelContext) var modelContext
  let items: [Item]

  var body: some View {
    List {
      ForEach(items) { item in
        Text(item.name)
      }
      .onMove(perform: moveRow)
    }
    .background(.backgroundPrimary)
    .scrollContentBackground(.hidden)
    .onAppear {
      editMode?.wrappedValue = .active
    }
  }
  
  private func moveRow(from source: IndexSet, to destination: Int) {
    var newItems = items
    newItems.move(fromOffsets: source, toOffset: destination)
    for (index, item) in newItems.enumerated() {
      item.sortOrder = index + 1
    }
  }
}

#Preview {
  ItemListSorter(items: [])
    .modelContainer(PreviewModelContainer.container)
}
