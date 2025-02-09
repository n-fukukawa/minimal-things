//
//  MyItemDetailHeader.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailHeader: View {
  let item: Item
  
  var body: some View {
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
  }
}

#Preview {
  MyItemDetailHeader(item: Item(name: "itemname", status: .owned))
}
