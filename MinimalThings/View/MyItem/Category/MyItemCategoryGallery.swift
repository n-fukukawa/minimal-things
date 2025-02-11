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
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(categoires) { category in
          MyItemCategoryGalleryRow(category: category)
        }
        MyItemCategoryGalleryRow(category: nil)
        Spacer()
      }
      .padding(.bottom)
    }
    .navigationDestination(for: Item.self) { item in
      MyItemDetail(item: item)
    }
    .padding(.top, 10)
  }
}

#Preview {
  MyItemCategoryGallery()
    .modelContainer(for: Item.self, inMemory: true)
}
