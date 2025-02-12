//
//  MyItemGalleryItem.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI

struct MyItemGalleryItem: View {
  @AppStorage("view.gallerySize") private var gallerySize: Int = 120
  var item: Item
  
  var body: some View {
    if item.images.count > 0 {
      ZStack {
        RoundedRectangle(cornerRadius: 5)
          .fill(Color(UIColor.systemBackground))
          .shadow(color: .gray.opacity(0.25), radius: 4, x: 1, y: 1)
          .frame(width: CGFloat(gallerySize), height: CGFloat(gallerySize))
        
        if let uiImage = UIImage(data: item.images[0]) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(width: CGFloat(gallerySize), height: CGFloat(gallerySize))
        } else {
          Text(item.name)
            .font(.caption)
            .frame(width: CGFloat(gallerySize), height: CGFloat(gallerySize))
        }
      }
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: Item.ItemStatus.owned.rawValue)
  return MyItemGalleryItem(item: item).modelContainer(for: Item.self, inMemory: true)
}
