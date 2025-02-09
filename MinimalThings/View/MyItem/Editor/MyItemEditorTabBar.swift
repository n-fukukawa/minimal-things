//
//  MyItemEditorTabBar.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemEditorTabBar: View {
  @Binding var activeTab: Int
  
  var body: some View {
    HStack(spacing: 0) {
      Button {
        activeTab = 1
      } label: {
        VStack {
          Text("基本").font(.subheadline)
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
          Text("詳細").font(.subheadline)
          Rectangle()
            .frame(height: 2)
            .opacity(activeTab == 2 ? 0.8 : 0.1)
        }
      }
      .frame(maxWidth: .infinity)
    }
  }
}

#Preview {
  MyItemEditorTabBar(activeTab: .constant(1))
}
