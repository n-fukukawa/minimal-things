//
//  WantedItemList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI
import SwiftData

struct WantedItemList: View {
  @Query private var items: [Item]
  
  init(searchText: String) {
    let predicate = Item.predicate(status: .wanted, searchText: searchText)
    _items = Query(filter: predicate, sort: \.updatedAt, order: SortOrder.reverse)
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 0) {
        ForEach(items) { item in
          NavigationLink {
            WantedItemDetail(item: item)
          } label: {
            WantedItemListItem(item: item)
          }
        }
      }
    }
  }
}

#Preview {
  WantedItemList(searchText: "")
}
