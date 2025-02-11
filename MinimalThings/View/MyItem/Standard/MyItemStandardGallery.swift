//
//  MyItemStandardGallery.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI
import SwiftData

struct MyItemStandardGallery: View {
  @AppStorage("view.sortOrder") private var sortOrder: ItemSortOrder = .reverse
  @Query private var items: [Item]
    
  init(searchText: String) {
    let predicate = Item.predicate(searchText: searchText)
    _items = Query(filter: predicate, sort: \.purchasedAt, order: sortOrder.value)
  }
  
  var gridItems = [GridItem(.adaptive(minimum: 100, maximum: 180), spacing: 5)]
  
  var body: some View {
    Text("")
    ScrollView {
      LazyVGrid(columns: gridItems, spacing: 5) {
        ForEach(items) { item in
          NavigationLink(value: item) {
            MyItemGalleryItem(item: item)
          }
        }
      }
      .navigationDestination(for: Item.self) { item in
        MyItemDetail(item: item)
      }
    }
  }
}

#Preview {
  MyItemStandardGallery(searchText: "")
}
