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
  
  private var gridItems = [GridItem(.adaptive(minimum: 80, maximum: 160), spacing: 10)]
  
  init(searchText: String) {
    let predicate = Item.predicate(status: .owned, searchText: searchText)
    _items = Query(filter: predicate, sort: \.purchasedAt, order: sortOrder.value)
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItems, spacing: 10) {
        ForEach(items) { item in
          GeometryReader { geometry in
            NavigationLink {
              MyItemDetail(item: item)
            } label: {
              MyItemGalleryItem(item: item, size: geometry.size.width)
            }
          }
        }
      }
      .padding(.horizontal)
    }
  }
}

#Preview {
  MyItemStandardGallery(searchText: "")
}
