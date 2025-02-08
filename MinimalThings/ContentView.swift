//
//  ContentView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var categories: [ItemCategory]
  
  var body: some View {
    TabView {
      MyItemView()
        .tabItem {
          Image(systemName: "house")
          Text("ホーム")
        }
    }
    .onAppear {
      createCategoriesIfNeed()
    }
  }
  
  func createCategoriesIfNeed() {
    if categories.isEmpty {
      let categoryNames = [
        "家電",
        "家具",
        "衣類",
        "日用品",
        "美容用品",
        "未分類",
      ]
      categoryNames.forEach({ name in
        modelContext.insert(ItemCategory(name: name))
      })
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
