//
//  MyItemDetailMemoView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemDetailReasonView: View {
  let item: Item
  
  var body: some View {
    Text(item.reasonWhyWant ?? "")
      .lineLimit(nil)
      .lineSpacing(5)
      .font(.subheadline)
      .padding(8)
  }
}

#Preview {
  MyItemDetailMemoView(item: Item(name: "itemname", status: Item.ItemStatus.wanted.rawValue))
}
