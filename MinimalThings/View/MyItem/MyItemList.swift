//
//  MyItemList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI
import SwiftData

struct MyItemList: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  
  @State private var searchText: String = ""
  
  var gridItems = [GridItem(.adaptive(minimum: 100, maximum: 180))]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItems, spacing: 10) {
        ForEach(items) { item in
          NavigationLink(value: item) {
            MyItemCard(item: item)
          }
        }
      }
      .navigationDestination(for: Item.self) { item in
        MyItemDetail(item: item)
      }
    }
    .toolbar {
      ToolbarItem {
        Button(action: addItem) {
          Label("Add Item", systemImage: "plus")
        }
      }
    }
    .searchable(text: $searchText)
    
  }
  
  private func addItem() {
    withAnimation {
      let newItem = Item(name: "Item", status: Item.ItemStatus.owned)
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  MyItemList()
    .modelContainer(for: Item.self, inMemory: true)
}
