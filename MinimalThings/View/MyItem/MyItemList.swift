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
  @State private var isEditorPresented = false
  
  var gridItems = [GridItem(.adaptive(minimum: 100, maximum: 180), spacing: 5)]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItems, spacing: 5) {
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
        Button {
          isEditorPresented.toggle()
        } label: {
          Label("追加", systemImage: "plus")
        }
      }
    }
    .searchable(text: $searchText)
    .sheet(isPresented: $isEditorPresented) {
      NavigationStack {
        MyItemEditor(dismissAction: { isEditorPresented = false })
          .navigationTitle("新規作成")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button {
                isEditorPresented = false
              } label : {
                Label("閉じる", systemImage: "xmark")
              }
            }
          }
      }
    }
  }
}

#Preview {
  MyItemList()
    .modelContainer(for: Item.self, inMemory: true)
}
