//
//  MyItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI

struct MyItemCard: View {
  var item: Item
  
  var body: some View {
    if item.images.count > 0, let uiImage = UIImage(data: item.images[0])  {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .clipped()
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(5)
    }
    
  }
}

#Preview {
  let item = Item(name: "item name", status: .owned)
  return MyItemCard(item: item).modelContainer(for: Item.self, inMemory: true)
}
