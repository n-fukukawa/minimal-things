//
//  SettingList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI

struct SettingList: View {
  var body: some View {
    List {
      NavigationLink {
        CategorySetting()
      } label: {
        Text("カテゴリ")
      }
    }
    .background(.backgroundPrimary)
    .scrollContentBackground(.hidden)
    .navigationTitle("設定")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  SettingList()
}
