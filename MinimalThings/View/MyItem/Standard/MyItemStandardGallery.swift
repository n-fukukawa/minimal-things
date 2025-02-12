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
  @AppStorage("view.gallerySize") private var gallerySize: Int = 120
  @Query private var items: [Item]
  
  private var gridItems = [GridItem(.fixed(120), spacing: 10)]
  
  init(searchText: String) {
    let predicate = Item.predicate(status: .owned, searchText: searchText)
    _items = Query(filter: predicate, sort: \.purchasedAt, order: sortOrder.value)
    gridItems = [GridItem(.adaptive(minimum: CGFloat(gallerySize), maximum: CGFloat(gallerySize)), spacing: 10)]
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItems, spacing: 10) {
        ForEach(items) { item in
          NavigationLink {
            MyItemDetail(item: item)
          } label: {
            MyItemGalleryItem(item: item)
          }
        }
      }
    }
  }
}

#Preview {
  MyItemStandardGallery(searchText: "")
}
