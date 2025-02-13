//
//  WantedItemDetailHeader.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemDetailHeader: View {
  let item: Item
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        VStack(alignment: .leading, spacing: 6) {
          Text(item.name)
            .textSelection(.enabled)
            .font(.headline)
            .fontWeight(.medium)
          
          if let brand = item.brand {
            Text(brand)
              .textSelection(.enabled)
              .font(.caption)
              .opacity(0.8)
          }
        }
        Spacer()
        if let price = item.price {
          Text("\(price)円")
        }
      }
      
      if let urlString = item.url, let url = URL(string: urlString) {
        HStack {
          Link(urlString, destination: url)
            .font(.subheadline)
            .foregroundStyle(.blue)
            .lineLimit(1)
            .truncationMode(.tail)
            .textSelection(.enabled)
          ShareLink("", item: url)
        }
      }
    }
  }
}

#Preview {
  WantedItemDetailHeader(item: Item(name: "itemname", status: Item.ItemStatus.wanted.rawValue))
}
