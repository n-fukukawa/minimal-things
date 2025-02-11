//
//  MyItemStandardList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/12.
//

import SwiftUI
import SwiftData

struct MyItemStandardList: View {
  @AppStorage("view.sortOrder") private var sortOrder: ItemSortOrder = .reverse
  @Query private var items: [Item]
  
  init(searchText: String) {
    let predicate = Item.predicate(searchText: searchText)
    _items = Query(filter: predicate, sort: \.purchasedAt, order: sortOrder.value)
  }
  
  var gridItems = [GridItem(.fixed(.infinity), spacing: 0)]
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(items) { item in
          NavigationLink(value: item) {
            MyItemListItem(item: item)
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
  MyItemStandardList(searchText: "")
}
