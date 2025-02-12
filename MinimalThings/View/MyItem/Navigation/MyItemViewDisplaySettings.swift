//
//  MyItemViewDisplaySettings.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/10.
//

import SwiftUI

struct MyItemViewDisplaySettings: View {
  @AppStorage("view.displayType") private var displayType: DisplayType = .gallery
  @AppStorage("view.sortOrder") private var sortOrder: ItemSortOrder = .reverse
  @AppStorage("view.groupingType") private var groupingType: GroupingType = .none

  var body: some View {
    Menu {
      Section("表示形式") {
        Picker("表示形式", selection: $displayType) {
          ForEach(DisplayType.allCases, id: \.self) { type in
            Label(type.name, systemImage: type.icon)
          }
        }
        .pickerStyle(.inline)
      }
      
      Section("グループ表示"){
        Picker("グループ表示", selection: $groupingType) {
          ForEach(GroupingType.allCases, id: \.self) { type in
            Text(type.name)
          }
        }
        .pickerStyle(.inline)
      }
      
      Section("購入日") {
        Picker("購入日", selection: $sortOrder) {
          ForEach([ItemSortOrder.reverse, .forward], id: \.self) { order in
            Label(order.name, systemImage: "")
          }
        }
        .pickerStyle(.inline)
      }
    } label: {
      Label("表示設定", systemImage: "ellipsis.circle")
    }
  }
}

#Preview {
  MyItemViewDisplaySettings()
}
