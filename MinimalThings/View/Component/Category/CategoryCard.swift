//
//  CategoryCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

struct CategoryCard: View {
  @Query var items: [Item]
  let category: ItemCategory?
  
  init(category: ItemCategory?) {
    self.category = category
    let predicate = Item.fetchByCategory(category: category)
    _items = Query(filter: predicate, sort: \.createdAt, order: .reverse)
  }
  
  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)
      
      ZStack {
        // MARK: - Background
        RoundedRectangle(cornerRadius: 10)
          .fill(.containerBackground)
          .shadow(color: .shadow, radius: 5, x: 0, y: 5)
        
        // MARK: - Content
        VStack(alignment: .leading, spacing: 0) {
          // MARK: - Edit Button
          HStack {
            Spacer()
            Button {} label: {
              Image(systemName: "ellipsis")
                .foregroundStyle(.foregroundTertiary)
            }
          }
          Spacer()
          // MARK: - Category name & items count
          VStack(alignment: .leading, spacing: 8) {
            Text(category?.name ?? "未分類")
              .font(.headline)
              .foregroundStyle(.foregroundPrimary)
            
            HStack(spacing: 3) {
              Text("\(items.count)")
              Text("items")
            }
            .foregroundStyle(.foregroundTertiary)
            .font(.caption)
          }
          Spacer()
          // MARK: - Arrow
          HStack {
            Spacer()
            StylishArrow(width: frame.maxX * 0.6, color: .foregroundTertiary)
          }
        }
        .padding(frame.maxX * 0.1)
      }
    }
  }
}

#Preview {
  return (
    CategoryCard(category: nil)
      .modelContainer(for: Item.self, inMemory: true)
      .frame(width: 200, height: 300)
  )
}
