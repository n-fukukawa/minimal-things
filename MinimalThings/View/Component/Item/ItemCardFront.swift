//
//  ItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

struct ItemCardFront: View {
  let item: Item
  
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
          // MARK: - Photo
          Image("photo")
            .resizable()
            .scaledToFit()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: .infinity)
          // MARK: - Title
          VStack(alignment: .leading, spacing: 8) {
            Text(item.name)
              .lineLimit(2)
              .font(.subheadline)
              .fontWeight(.semibold)
              .foregroundStyle(.foregroundSecondary)
            
            if let maker = item.maker {
              Text(maker)
                .lineLimit(1)
                .font(.caption)
                .foregroundStyle(.foregroundTertiary)
            }
          }
          .padding(.top, 20)
          Spacer()
          // MARK: - Arrow
          HStack {
            Spacer()
            StylishArrow(width: frame.maxX * 0.5, color: .foregroundTertiary)
          }
        }
        .padding(frame.maxX * 0.1)
      }
    }
  }
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCardFront(item: items[0])
    .frame(width: 300, height: 450)
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCardFront(item: items[1])
    .frame(width: 300, height: 450)
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCardFront(item: items[2])
    .frame(width: 300, height: 450)
}
