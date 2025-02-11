//
//  MyItemCategoryListSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/12.
//

import SwiftUI
import SwiftData

struct MyItemCategoryListSection: View {
  @Query private var items: [Item]
  let category: ItemCategory?
  
  init(category: ItemCategory?, searchText: String) {
    self.category = category
    let predicate = Item.fetchByCategory(category: category, searchText: searchText)
    _items = Query(filter: predicate)
  }
  
  var body: some View {
    if !items.isEmpty {
      Section {
        VStack(spacing: 0) {
          ForEach(items) { item in
            NavigationLink(value: item) {
              MyItemListItem(item: item)
            }
          }
        }
        .navigationDestination(for: Item.self) { item in
          MyItemDetail(item: item)
        }
      } header: {
        HStack {
          Text(category?.name ?? "未分類")
            .font(.subheadline)
            .foregroundStyle(Color.foreground)
            .padding(4)
            
          Spacer()
        }.background(Color(UIColor.systemGray6))
      }
    }
  }
}

#Preview {
  MyItemCategoryListSection(category: nil, searchText: "")
}
