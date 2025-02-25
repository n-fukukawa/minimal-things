//
//  CategoryCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

struct CategoryCard: View {
  @Namespace var namespace
  @Environment(\.dismiss) var dismiss
  @Query var items: [Item]
  
  let category: ItemCategory?
  let detail: Bool
  
  init(category: ItemCategory?, detail: Bool = false) {
    self.category = category
    self.detail = detail
    let predicate = Item.fetchByCategory(category: category)
    _items = Query(filter: predicate, sort: \.sortOrder, order: .forward)
  }
  
  var body: some View {
    if detail {
      content
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    } else {
      content
    }
  }
  
  var content: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)
      
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(detail ? .backgroundPrimary : .containerBackground)
          .shadow(color: .shadow, radius: 5, x: 0, y: 5)
        
        VStack(alignment: .leading, spacing: 0) {
          Spacer()
          header.padding(.horizontal, detail ? 30 : frame.maxX * 0.1)
          Spacer()
          
          if detail {
            itemList.padding(.top, 10)
          } else {
            HStack {
              Spacer()
              StylishArrow(width: frame.maxX * 0.3, color: .foregroundTertiary)
            }
            .padding(.horizontal, frame.maxX * 0.1)
          }
        }
        .padding(.vertical, detail ? frame.maxX * 0.08 : frame.maxX * 0.1)
        .padding(.top, detail ? 45 : 0)
      }
    }
  }
  
  private var header: some View {
    HStack(spacing: 15) {
      if detail { backButton }
      headerTitle
      Spacer()
      if detail { sortButton }
    }
  }
  
  private var headerTitle: some View {
    VStack(alignment: .leading, spacing: detail ? 2 : 8) {
      Text(category?.name ?? "未分類")
        .lineLimit(2)
        .multilineTextAlignment(.leading)
        .font(.headline)
        .foregroundStyle(.foregroundPrimary)
      
      HStack(spacing: 3) {
        Text("\(items.count)")
        Text("items")
      }
      .foregroundStyle(.foregroundTertiary)
      .font(.caption)
    }
    .scaleEffect(detail ? 1.4 : 1, anchor: .leading)
  }
  
  private var backButton: some View {
    Button { dismiss() } label: {
      Image(systemName: "chevron.left")
        .font(.title3)
        .tint(.foregroundSecondary)
    }
  }
  
  private var sortButton: some View {
    NavigationLink {
      ItemListSorter(items: items)
    } label: {
      Image(systemName: "arrow.up.arrow.down")
        .tint(.foregroundSecondary)
    }
  }
  
  private var itemList: some View {
    let gridItems = [GridItem(.adaptive(minimum: 150, maximum: 240), spacing: 0)]
    return NavigationStack {
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          LazyVGrid(columns: gridItems, spacing: 0) {
            ForEach(items) { item in
              NavigationLink {
                ZStack {
                  Rectangle()
                    .fill(.backgroundPrimary)
                    .ignoresSafeArea()
                  
                  VStack {
                    ItemCard(item: item, detail: true)
                      .navigationTransition(.zoom(sourceID: item.id, in: namespace))
                    Spacer()
                  }
                }
              } label: {
                ItemCard(item: item)
                  .matchedTransitionSource(id: item.id, in: namespace)
              }
            }
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  return (
    CategoryCard(category: nil)
      .modelContainer(PreviewModelContainer.container)
      .frame(width: 200, height: 300)
  )
}

#Preview {
  return (
    CategoryCard(category: nil, detail: true)
      .modelContainer(PreviewModelContainer.container)
  )
}
