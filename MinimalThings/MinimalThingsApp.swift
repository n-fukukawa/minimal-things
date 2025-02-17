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
    
    for category in categories {
      container.mainContext.insert(category)
    }
    
    for _item in items {
      let item = Item(name: _item["name"] as! String)
      item.category = categories[Int.random(in: 0..<categories.count)]
      item.maker = _item["maker"] as! String?
      item.comment = _item["comment"] as! String?
      item.purchaseDate = _item["purchaseDate"] as! Date?
      item.price = _item["price"] as! Int?
      item.url = _item["url"] as! String?
      container.mainContext.insert(item)
    }
    
    
    return container
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()
