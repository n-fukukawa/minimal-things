//
//  MyItemDetailTabBar.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailTabBar: View {
  @Binding var activeTab: Int
  
  var body: some View {
    HStack(spacing: 0) {
      Button {
        activeTab = 1
      } label: {
        VStack {
          Label("コメント", systemImage: "text.bubble")
            .labelStyle(.iconOnly)
            .padding(.bottom, 2)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 1 ? 0.8 : 0.1)
        }
      }
      .frame(maxWidth: .infinity)
      
      Button {
        activeTab = 2
      } label: {
        VStack {
          Label("仕様", systemImage: "info.circle")
            .labelStyle(.iconOnly)
            .padding(.bottom, 2)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 2 ? 0.8 : 0.1)
        }
      }
      .frame(maxWidth: .infinity)
      
      Button {
        activeTab = 3
      } label: {
        VStack {
          Label("購入情報", systemImage: "cart")
            .labelStyle(.iconOnly)
            .padding(.bottom, 2)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 3 ? 0.8 : 0.1)
        }
      }
      .frame(maxWidth: .infinity)
      Spacer()
    }
  }
}

#Preview {
  MyItemDetailTabBar(activeTab: .constant(1))
}
