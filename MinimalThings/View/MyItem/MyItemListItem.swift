//
//  MyItemListItem.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/12.
//

import SwiftUI

struct MyItemListItem: View {
  let item: Item
  
  var body: some View {
    if item.images.count > 0 {
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          if let uiImage = UIImage(data: item.images[0]) {
            Image(uiImage: uiImage)
              .resizable()
              .frame(width: 80, height: 80)
              .aspectRatio(contentMode: .fill)
          } else {
            Text(item.name)
              .font(.caption)
              .frame(width: 80, height: 80)
            Rectangle()
              .fill(Color(UIColor.systemGray5).opacity(0.5)).frame(width: 1)
          }
          
          Text(item.name)
            .font(.subheadline)
            .lineLimit(2)
            .padding(.leading, 8)
          
          Spacer()
        }
        Rectangle()
          .fill(Color(UIColor.systemGray5).opacity(0.5))
          .frame(height: 1)
      }
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: .owned)
  return MyItemListItem(item: item).modelContainer(for: Item.self, inMemory: true)
}
