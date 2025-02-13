//
//  MyItemCategoryGallerySection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/11.
//

import SwiftUI
import SwiftData

struct MyItemCategoryGallerySection: View {
  @Query private var items: [Item]
  let category: ItemCategory?
  
  private var itemHeight = CGFloat(100)
  private var gridItems = [GridItem(.fixed(100), spacing: 5)]
  
  init(category: ItemCategory?, searchText: String) {
    self.category = category
    let predicate = Item.fetchByCategory(status: .owned, category: category, searchText: searchText)
    _items = Query(filter: predicate)
  }
  
  var body: some View {
    if !items.isEmpty {
      Section {
        VStack(alignment: .leading, spacing: 0) {
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridItems) {
              ForEach(items) { item in
                NavigationLink {
                  MyItemDetail(item: item)
                } label: {
                  MyItemGalleryItem(item: item, size: itemHeight)
                }
              }
            }
            .frame(height: CGFloat(itemHeight))
            .padding(.horizontal)
            .padding(.vertical, 3)
          }
        }
        .padding(.bottom, 30)
      } header: {
        ZStack {
          Rectangle()
            .fill(Color(UIColor.systemBackground))
          
          HStack {
            Text(category?.name ?? "未分類")
              .font(.title3)
              .fontWeight(.ultraLight)
              .tracking(2)
              .background(Color(UIColor.systemBackground))
              .padding(.leading)
              .padding(.vertical, 8)
            Spacer()
          }
        }
      }
    }
  }
}

#Preview {
  MyItemCategoryGallerySection(category: nil, searchText: "")
}
