//
//  MyItemDetailMemoView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailMemoView: View {
  let item: Item
  
  var body: some View {
    Text(item.memo ?? "")
      .lineLimit(nil)
      .lineSpacing(5)
      .font(.subheadline)
      .padding(8)
  }
}

#Preview {
  MyItemDetailMemoView(item: Item(name: "itemname", status: .owned))
}
