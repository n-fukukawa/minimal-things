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
      ZStack {
        RoundedRectangle(cornerRadius: 0)
          .fill(Color(UIColor.systemBackground))
          .shadow(color: .gray.opacity(0.2), radius: 4, x: 1, y: 2)
        
        HStack(spacing: 0) {
          if let uiImage = UIImage(data: item.images[0]) {
            Image(uiImage: uiImage)
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
          } else {
            Text(item.name)
              .font(.caption)
              .frame(width: 80, height: 80)
          }
          
          Text(item.name)
            .font(.subheadline)
            .lineLimit(2)
            .padding(8)
          
          Spacer()
        }
      }
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: Item.ItemStatus.owned.rawValue)
  return MyItemListItem(item: item).modelContainer(for: Item.self, inMemory: true)
}
