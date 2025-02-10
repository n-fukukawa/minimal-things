//
//  MyItemViewSetting.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/10.
//

import SwiftUI

struct MyItemViewSetting: View {
  @Binding var listType: ListType
  @Binding var sortOrder: SortOrder
  
  var body: some View {
    Menu {
      Picker("表示形式", selection: $listType) {
        ForEach(ListType.allCases, id: \.self) { type in
          Label(type.name, systemImage: type.icon)
        }
      }
      Picker("並び順", selection: $sortOrder) {
        ForEach([SortOrder.reverse, .forward], id: \.self) { order in
          Text(order.name)
        }
      }
    } label: {
      Label("表示形式", systemImage: "ellipsis.circle")
    }
  }
}

#Preview {
  MyItemViewSetting(
    listType: .constant(ListType.grid),
    sortOrder: .constant(.reverse)
  )
}
