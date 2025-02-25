//
//  MinimalThingsApp.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/01/25.
//

import SwiftUI
import SwiftData

@main
struct MinimalThingsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
  }
}

@MainActor
let sharedModelContainer: ModelContainer = {
  let schema = Schema([
    Item.self, ItemCategory.self
  ])
  
  let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
  
  do {
    let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
    
    var categoryFetchDescriptor = FetchDescriptor<ItemCategory>()
    categoryFetchDescriptor.fetchLimit = 1
    
    guard try container.mainContext.fetch(categoryFetchDescriptor).count == 0 else { return container }
    
    for (index, category) in defaultCategories.enumerated() {
      category.sortOrder = index + 1
      container.mainContext.insert(category)
    }
    
    return container
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()

let defaultCategories: [ItemCategory] = [
  ItemCategory(name: String(localized: "category:Clothing")),
  ItemCategory(name: String(localized: "category:Kitchen")),
  ItemCategory(name: String(localized: "category:Furniture")),
  ItemCategory(name: String(localized: "category:Consumer electronics")),
  ItemCategory(name: String(localized: "category:Gadgets")),
  ItemCategory(name: String(localized: "category:Bedclothes")),
  ItemCategory(name: String(localized: "category:Bathroom")),
  ItemCategory(name: String(localized: "category:Hobby items")),
]
