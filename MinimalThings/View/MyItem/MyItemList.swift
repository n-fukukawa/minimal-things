//
//  MyItemList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI
import SwiftData

struct MyItemList: View {
  @Query private var items: [Item]
    
  init(sortOrder: SortOrder, searchText: String) {
    let predicate = Item.predicate(searchText: searchText)
    _items = Query(filter: predicate, sort: \.purchasedAt, order: sortOrder)
  }
  
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
  }
}

#Preview {
  MyItemList(sortOrder: SortOrder.reverse, searchText: "")
}
