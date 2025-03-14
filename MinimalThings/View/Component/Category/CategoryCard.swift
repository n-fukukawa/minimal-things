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
  
  let category: ItemCategory?
  let items: [Item]
  let detail: Bool
  
  @State private var isEditorPresented: Bool = false
  
  init(category: ItemCategory?, items: [Item], detail: Bool = false) {
    self.category = category
    self.items = items.sorted{ $0.sortOrder < $1.sortOrder }
    self.detail = detail
  }
  
  var body: some View {
    if detail {
      VStack(spacing: 0) {
        content
          .ignoresSafeArea()
          .navigationBarBackButtonHidden()
        
        BannerContentView()
      }
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
          .shadow(color: detail ? .clear : .shadow, radius: 5, x: 0, y: 5)
        
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
        .padding(.top, detail ? 75 : frame.maxX * 0.1)
        .padding(.bottom, detail ? 0 : frame.maxX * 0.1)
      }
    }
  }
  
  private var header: some View {
    HStack(spacing: 15) {
      if detail { backButton }
      headerTitle
      Spacer()
      if detail {
        addButton
        sortButton
      }
    }
  }
  
  private var headerTitle: some View {
    VStack(alignment: .leading, spacing: detail ? 2 : 8) {
      Text(category?.name ?? String(localized: "Uncategorized"))
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
  
  private var addButton: some View {
    Button {
      isEditorPresented.toggle()
    } label: {
      Image(systemName: "plus")
        .font(.title3)
        .tint(.foregroundSecondary)
    }
    .sheet(isPresented: $isEditorPresented) {
      NavigationStack {
        ItemEditor(defaultCategory: category)
      }
    }
  }
  
  private var sortButton: some View {
    NavigationLink {
      ItemListSorter(items: items)
    } label: {
      Image(systemName: "arrow.up.arrow.down")
        .tint(.foregroundSecondary)
    }
    .disabled(items.count == 0)
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
                      .navigationTransition(.zoom(sourceID: item.uuid.uuidString, in: namespace))
                    Spacer()
                  }
                }
              } label: {
                ItemCard(item: item)
                  .matchedTransitionSource(id: item.uuid.uuidString, in: namespace)
              }
            }
          }
          .padding(.vertical)
        }
        .padding(.horizontal)
        
        if items.isEmpty {
          VStack(spacing: 15) {
            Text("No items yet.")
              .foregroundStyle(.buttonNormal)
            Button { isEditorPresented.toggle() }
            label: {
              Label(
                title: { Text("Add item") },
                icon: { Image(systemName: "plus") }
              )
              .padding(.vertical, 5)
              .padding(.horizontal, 15)
              .background(Color.buttonNormal)
              .foregroundStyle(.buttonForeground)
              .clipShape(RoundedRectangle(cornerRadius: 3))
            }
          }
        }
      }
    }
  }
}

#Preview {
  return (
    CategoryCard(category: nil, items: [])
      .modelContainer(PreviewModelContainer.container)
      .frame(width: 200, height: 300)
  )
}

#Preview {
  return (
    CategoryCard(category: nil, items: [], detail: true)
      .modelContainer(PreviewModelContainer.container)
  )
}
