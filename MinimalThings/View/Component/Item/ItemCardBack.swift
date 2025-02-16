//
//  ItemCardBack.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

struct ItemCardBack: View {
  let item: Item
  let dateFormatStyle = Date.FormatStyle(date: .numeric, time: .omitted)
  
  var body: some View {
    GeometryReader { geometry in
      let frame = geometry.frame(in: .local)
      let paddingSize = frame.maxX * 0.1
      
      ZStack {
        // MARK: - Background
        RoundedRectangle(cornerRadius: 10)
          .fill(.containerBackground)
          .shadow(color: .shadow, radius: 5, x: 0, y: 5)
        
        // MARK: - Content
        VStack(alignment: .leading, spacing: 0) {
          // MARK: - Header
          VStack(alignment: .leading, spacing: 0) {
            Text(item.name)
              .lineLimit(2)
              .font(.subheadline)
              .fontWeight(.semibold)
              .foregroundStyle(.foregroundSecondary)
              .padding(.bottom, 8)
            
            HStack(spacing: 0) {
              if let maker = item.maker {
                Text(maker)
                  .lineLimit(1)
                  .font(.caption)
                  .foregroundStyle(.foregroundTertiary)
              }
              Spacer()
              Button {
                //
              } label: {
                Image(systemName: "ellipsis")
                  .foregroundStyle(.foregroundTertiary)
                  .padding(.leading, 8)
              }
            }
            .padding(.bottom, 20)
            
            Divider()
              .foregroundStyle(.containerDivider)
          }
          .padding(.top, paddingSize)
          
          // MARK: - comment
          ScrollView(.vertical, showsIndicators: false) {
            Text(item.comment ?? "")
              .multilineTextAlignment(.leading)
              .font(.caption)
              .foregroundStyle(.foregroundSecondary)
              .padding(.vertical, paddingSize)
              .padding(.trailing)
          }
          .padding(.bottom, paddingSize)
          
          // MARK: - detail
          VStack(alignment: .leading, spacing: 15) {
            if let purchaseDate = item.purchaseDate {
              IconLabel(
                label: dateFormatStyle.format(purchaseDate),
                icon: "calendar"
              )
            }
            
            if let price = item.price {
              IconLabel(
                label: "\(price.formatted())円",
                icon: "yensign.square"
              )
            }
            
            if let url = item.url {
              IconLabel(
                label: url,
                icon: "link",
                isURL: true
              )
            }
          }
          .padding(.bottom, paddingSize / 2)
          
          
          Spacer()
          // MARK: - Arrow
          HStack {
            StylishArrowBack(width: frame.maxX * 0.5, color: .foregroundTertiary)
            Spacer()
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
  
  return ItemCardBack(item: items[0])
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
  
  return ItemCardBack(item: items[1])
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
  
  return ItemCardBack(item: items[2])
    .frame(width: 300, height: 450)
}
