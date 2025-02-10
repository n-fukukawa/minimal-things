//
//  MyItemView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/07.
//

import SwiftUI

struct MyItemView: View {
  @AppStorage("view.listType") private var listType: ListType = ListType.grid
  @State private var sortOrder: SortOrder = SortOrder.reverse
  @State private var searchText: String = ""
  @State private var isEditorPresented = false
  
  var body: some View {
    NavigationStack {
      Group {
        if listType == ListType.grid {
          MyItemList(sortOrder: sortOrder, searchText: searchText)
        }
        
        if listType == ListType.category {
          MyItemCategoryList()
        }
      }
      .searchable(text: $searchText)
      .sheet(isPresented: $isEditorPresented) {
        NavigationStack {
          MyItemEditor(dismissAction: { isEditorPresented = false })
            .navigationTitle("新規作成")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
              ToolbarItem(placement: .cancellationAction) {
                Button {
                  isEditorPresented = false
                } label : {
                  Label("閉じる", systemImage: "xmark")
                }
              }
            }
        }
      }
      .toolbar {
        ToolbarItemGroup(placement: .topBarTrailing) {
          MyItemViewSetting(listType: $listType, sortOrder: $sortOrder)
          Label("追加", systemImage: "plus")
            .onTapGesture {
              isEditorPresented.toggle()
            }
        }
      }
    }
  }
}

enum ListType: String, CaseIterable {
  case grid
  case category
  case list
  
  var name: String {
    switch self {
    case .grid: return "標準"
    case .category: return "カテゴリー"
    case .list: return "リスト"
    }
  }
  
  var icon: String {
    switch self {
    case .grid: return "square.grid.3x3"
    case .category: return "square.grid.3x1.below.line.grid.1x2"
    case .list: return "list.dash"
    }
  }
}

extension SortOrder {
  var name: String {
    switch self {
    case .reverse: return "購入日の新しい順"
    case .forward: return "購入日の古い順"
    }
  }
}

#Preview {
  MyItemView()
}
