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
    let predicate = Item.fetchByCategory(status: .owned, category: category, searchText: searchText)
    _items = Query(filter: predicate)
  }
  
  var body: some View {
    if !items.isEmpty {
      Section {
        VStack(spacing: 6) {
          ForEach(items) { item in
            NavigationLink {
              MyItemDetail(item: item)
            } label: {
              MyItemListItem(item: item)
            }
          }
        }
        .padding(.top, 3)
        .padding(.horizontal)
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
  MyItemCategoryListSection(category: nil, searchText: "")
}
