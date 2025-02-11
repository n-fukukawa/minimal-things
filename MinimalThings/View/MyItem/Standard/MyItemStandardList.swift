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
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MyItemStandardList(searchText: "")
}
