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
    Image("turtlerock")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .cornerRadius(10)
      
  }
}

#Preview {
  let item = Item(name: "item name", status: .owned)
  return MyItemCard(item: item).modelContainer(for: Item.self, inMemory: true)
}
