//
//  MyItemViewSetting.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/10.
//

import SwiftUI

struct MyItemViewSetting: View {
  @AppStorage("view.displayType") private var displayType: DisplayType = .gallery
  @AppStorage("view.groupingType") private var groupingType: GroupingType = .none
  @AppStorage("view.sortOrder") private var sortOrder: ItemSortOrder = .reverse
  
  var body: some View {
    Menu {
      Section(header: Text("グループ化")) {
        Picker("グルーピング", selection: $groupingType) {
          ForEach(GroupingType.allCases, id: \.self) { type in
            Text(type.name)
          }
        }
      }
      Section("表示形式") {
        Picker("表示形式", selection: $displayType) {
          ForEach(DisplayType.allCases, id: \.self) { type in
            Label(type.name, systemImage: type.icon)
          }
        }
      }
      Section("並び順") {
        Picker("並び順", selection: $sortOrder) {
          ForEach([ItemSortOrder.reverse, .forward], id: \.self) { order in
            Text(order.name)
          }
        }
      }
    } label: {
      Label("表示形式", systemImage: "ellipsis.circle")
    }
  }
}

#Preview {
  MyItemViewSetting()
}
