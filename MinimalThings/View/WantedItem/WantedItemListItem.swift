//
//  WantedItemListItem.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemListItem: View {
  let item: Item
  
  var body: some View {
    VStack {
      HStack(spacing: 0) {
        VStack {
          Text(item.name)
            .font(.subheadline)
          
          if let brand = item.brand {
            Text(brand)
              .font(.caption)
          }
        }
        
        Spacer()
      }
      .padding()
      
      Rectangle()
        .fill(Color(UIColor.systemGray5).opacity(0.5))
        .frame(height: 1)
    }
  }
}

#Preview {
  WantedItemListItem(item: Item(
    name: "item name",
    status: Item.ItemStatus.wanted.rawValue
  ))
}
