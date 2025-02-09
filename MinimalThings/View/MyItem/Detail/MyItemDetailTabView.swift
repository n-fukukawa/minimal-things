//
//  MyItemDetailTabView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailTabView: View {
  let item: Item
  @State private var activeTab: Int = 1
  
  var body: some View {
    VStack {
      MyItemDetailTabBar(activeTab: $activeTab)
      
      if activeTab == 1 {
        MyItemDetailMemoView(item: item)
      }
      
      if activeTab == 2 {
        MyItemDetailSpecView(item: item)
      }
      
      if activeTab == 3 {
        MyItemDetailPurchaseInfoView(item: item)
      }
    }
  }
}

#Preview {
  MyItemDetailTabView(item: Item(name: "", status: .owned))
}
