//
//  MyItemCategoryGalleryRow.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/11.
//

import SwiftUI
import SwiftData

struct MyItemCategoryGalleryRow: View {
  @Query private var items: [Item]
  let category: ItemCategory?
  
  init(category: ItemCategory?, searchText: String) {
    self.category = category
    let predicate = Item.fetchByCategory(category: category, searchText: searchText)
    _items = Query(filter: predicate)
  }
  
  var gridItems = [GridItem(.fixed(120), spacing: 5)]
  
  var body: some View {
    if !items.isEmpty {
      VStack(alignment: .leading, spacing: 5) {
        Text(category?.name ?? "未分類")
          .font(.subheadline)
          .foregroundStyle(Color.foreground)
          .padding(.leading)
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHGrid(rows: gridItems) {
            ForEach(items) { item in
              NavigationLink(value: item) {
                MyItemGalleryItem(item: item)
              }
            }
          }
          .frame(maxHeight: 120)
          .padding(.horizontal)
        }
      }
    }
  }
}

#Preview {
  MyItemCategoryGalleryRow(category: nil, searchText: "")
}
