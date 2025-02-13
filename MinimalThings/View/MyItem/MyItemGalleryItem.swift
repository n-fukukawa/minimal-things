//
//  MyItemGalleryItem.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI

struct MyItemGalleryItem: View {
  var item: Item
  var size: CGFloat
  
  var body: some View {
    if item.images.count > 0 {
      ZStack {
        RoundedRectangle(cornerRadius: 5)
          .fill(Color(UIColor.systemBackground))
          .shadow(color: .gray.opacity(0.2), radius: 4, x: 1, y: 2)
        
        if let uiImage = UIImage(data: item.images[0]) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        } else {
          Text(item.name)
            .font(.caption)
            .frame(width: size, height: size)
        }
      }
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: Item.ItemStatus.owned.rawValue)
  return MyItemGalleryItem(
    item: item,
    size: 100
  ).modelContainer(for: Item.self, inMemory: true)
}
