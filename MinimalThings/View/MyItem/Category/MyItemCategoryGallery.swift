//
//  MyItemCategoryGallery.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/10.
//

import SwiftUI
import SwiftData

struct MyItemCategoryGallery: View {
  @Query private var items: [Item]
  @Query private var categoires: [ItemCategory]
  
  let searchText: String
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
        ForEach(categoires) { category in
          MyItemCategoryGallerySection(category: category, searchText: searchText)
        }
        MyItemCategoryGallerySection(category: nil, searchText: searchText)
        Spacer()
      }
      .padding(.bottom)
    }
    .padding(.top, 10)
  }
}

#Preview {
  MyItemCategoryGallery(searchText: "")
    .modelContainer(for: Item.self, inMemory: true)
}
