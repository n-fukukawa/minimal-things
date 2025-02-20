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
  let detail: Bool
  
  init(item: Item, detail: Bool = false) {
    self.item = item
    self.detail = detail
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: detail ? 10 : 5)
        .fill(.containerBackground)
        .shadow(color: .shadow, radius: detail ? 3 : 2, x: 0, y: detail ? 3 : 1)
      
      VStack(alignment: .leading, spacing: 0) {
        Image("photo")
          .resizable()
          .scaledToFit()
          .aspectRatio(1, contentMode: .fit)
          .frame(width: .infinity, height: .infinity)
          .clipShape(UnevenRoundedRectangle(topLeadingRadius: detail ? 0 : 5, topTrailingRadius: detail ? 0 : 5))
        
        VStack(alignment: .leading, spacing: 8) {
          Text(item.name)
            .lineLimit(2, reservesSpace: !detail)
            .multilineTextAlignment(.leading)
            .font(detail ? .title3 : .caption)
            .fontWeight(.semibold)
            .foregroundStyle(.foregroundSecondary)
          
          if detail, let maker = item.maker {
            Text(maker)
              .lineLimit(1)
              .font(detail ? .body : .caption2)
              .foregroundStyle(.foregroundTertiary)
          }
        }
        .padding(.top, detail ? 30 : 12)
        .padding(.bottom, detail ? 0 : 15)
        .padding(.horizontal, detail ? 0 : 10)
        
        if detail {
          Spacer()
          HStack {
            Spacer()
            StylishArrow(width: SCREEN_MAXX * 0.3, color: .foregroundTertiary)
          }
        }
      }
      .padding(detail ? SCREEN_MAXX * 0.07 : 0)
    }
    .padding(detail ? 0 : 6)
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
  
  return ItemCardFront(item: items[0], detail: true)
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
  
  return ItemCardFront(item: items[1], detail: true)
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
    .frame(width: 300, height: 300)
}
