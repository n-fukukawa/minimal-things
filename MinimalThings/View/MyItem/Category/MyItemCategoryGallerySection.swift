//
//  MyItemCategoryGallerySection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/11.
//

import SwiftUI
import SwiftData

struct MyItemCategoryGallerySection: View {
  @AppStorage("view.gallerySize") private var gallerySize: Int = 120
  @Query private var items: [Item]
  let category: ItemCategory?
  
  private var gridItems = [GridItem(.fixed(120), spacing: 5)]
  
  init(category: ItemCategory?, searchText: String) {
    self.category = category
    let predicate = Item.fetchByCategory(status: .owned, category: category, searchText: searchText)
    _items = Query(filter: predicate)
    gridItems = [GridItem(.fixed(CGFloat(gallerySize)), spacing: 5)]
  }
  
  var body: some View {
    if !items.isEmpty {
      Section {
        VStack(alignment: .leading, spacing: 5) {
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridItems) {
              ForEach(items) { item in
                NavigationLink {
                  MyItemDetail(item: item)
                } label: {
                  MyItemGalleryItem(item: item)
                }
              }
            }
            .frame(height: CGFloat(gallerySize))
            .padding(10)
          }
        }
      } header: {
        HStack {
          Text(category?.name ?? "未分類")
            .font(.subheadline)
            .padding(4)
          
          Spacer()
        }.background(Color(UIColor.systemGray6))
      }
    }
  }
}

#Preview {
  MyItemCategoryGallerySection(category: nil, searchText: "")
}
