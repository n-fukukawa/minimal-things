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
          Text("メモ").font(.subheadline)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 1 ? 0.8 : 0.1)
        }
      }
      .frame(width: .infinity)
      
      Button {
        activeTab = 2
      } label: {
        VStack {
          Text("仕様").font(.subheadline)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 2 ? 0.8 : 0.1)
        }
      }
      .frame(width: .infinity)
      
      Button {
        activeTab = 3
      } label: {
        VStack {
          Text("購入情報").font(.subheadline)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 3 ? 0.8 : 0.1)
        }
      }
      .frame(width: .infinity)
      Spacer()
    }
  }
}

#Preview {
  MyItemDetailTabBar(activeTab: .constant(1))
}
