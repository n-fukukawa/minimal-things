//
//  MyItemCategoryList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/12.
//

import SwiftUI
import SwiftData

struct MyItemCategoryList: View {
  @Query private var categoires: [ItemCategory]
  
  let searchText: String
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
        ForEach(categoires) { category in
          MyItemCategoryListSection(category: category, searchText: searchText)
        }
        MyItemCategoryListSection(category: nil, searchText: searchText)
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
  MyItemCategoryList(searchText: "")
}
