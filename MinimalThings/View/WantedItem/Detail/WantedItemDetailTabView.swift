//
//  WantedItemDetailTabView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemDetailTabView: View {
  let item: Item
  @State private var activeTab: Int = 1
  
  var body: some View {
    VStack(alignment: .leading) {
      WantedItemDetailTabBar(activeTab: $activeTab)
      
      if activeTab == 1 {
        WantedItemDetailReasonView(item: item)
      }
      
      if activeTab == 2 {
        WantedItemDetailSpecView(item: item)
      }
    }
  }
}

#Preview {
  WantedItemDetailTabView(item: Item(name: "", status: Item.ItemStatus.wanted.rawValue))
}
