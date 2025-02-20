//
//  ItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData

struct ItemCard: View {
  @Environment(\.dismiss) var dismiss
  var item: Item
  var detail: Bool
  
  init(item: Item, detail: Bool = false) {
    self.item = item
    self.detail = detail
  }
  
  let paddingSize = SCREEN_MAXX * 0.07
  
  var body: some View {
    if detail {
      content
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    } else {
      ZStack {
        RoundedRectangle(cornerRadius: detail ? 10 : 5)
          .fill(.containerBackground)
          .shadow(color: .shadow, radius: 2, x: 0, y: 1)
        content
      }
      .padding(6)
    }
  }
  
  private var content: some View {
    return ZStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 0) {
          photo
          Divider()
          VStack(alignment: .leading, spacing: 0) {
            itemTitle
            if detail {
              makerText.padding(.top, 8)
              commentText.padding(.top, paddingSize)
              itemDetails.padding(.top, paddingSize)
            }
          }
          .padding(.top, detail ? 30 : 12)
          .padding(.bottom, detail ? 15 : 15)
          .padding(.horizontal, detail ? SCREEN_MAXX * 0.07 : 10)
        }
      }
      if detail { hoverActionButtons }
    }
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }
  
  private var photo: some View {
    Image("photo")
      .resizable()
      .scaledToFit()
      .aspectRatio(1, contentMode: .fit)
      .clipShape(UnevenRoundedRectangle(
        topLeadingRadius: detail ? 0 : 5, topTrailingRadius: detail ? 0 : 5)
      )
      .frame(
        maxWidth: detail ? SCREEN_MAXX : .infinity,
        maxHeight: detail ? SCREEN_MAXX : .infinity
      )
  }
  
  private var itemTitle: some View {
    Text(item.name)
      .lineLimit(2, reservesSpace: !detail)
      .multilineTextAlignment(.leading)
      .font(detail ? .title2 : .caption)
      .fontWeight(.semibold)
      .foregroundStyle(.foregroundSecondary)
  }
  
  @ViewBuilder
  private var makerText: some View {
    if let maker = item.maker {
      Text(maker)
        .lineLimit(1)
        .font(.body)
        .foregroundStyle(.foregroundTertiary)
    }
  }
  
  @ViewBuilder
  private var commentText: some View {
    if let comment = item.comment {
      Text(comment)
        .multilineTextAlignment(.leading)
        .font(.body)
        .foregroundStyle(.foregroundSecondary)
        .padding(.trailing)
    }
  }
  
  @ViewBuilder
  private var itemDetails: some View {
    let dateFormatStyle = Date.FormatStyle(date: .numeric, time: .omitted)
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
  }
  
  private var hoverActionButtons: some View {
    HStack {
      Button {
        dismiss()
      } label: { Image(systemName: "xmark") }
        .buttonStyle(HoverActionButtonStyle())
      Spacer()
      Button {
        dismiss()
      } label: { Image(systemName: "ellipsis") }
        .buttonStyle(HoverActionButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding(.horizontal, 25)
    .padding(.top, 30)
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
  
  return ItemCard(item: items[0])
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCard(item: items[0], detail: true)
    .frame(width: 300, height: 450)
}



