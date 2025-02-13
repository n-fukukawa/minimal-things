//
//  MyItemView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/07.
//

import SwiftUI

struct MyItemView: View {
  @AppStorage("view.displayType") private var displayType: DisplayType = .gallery
  @AppStorage("view.sortOrder") private var sortOrder: ItemSortOrder = .reverse
  @AppStorage("view.groupingType") private var groupingType: GroupingType = .none
  @State private var searchText: String = ""
  @State private var isEditorPresented = false
  
  var body: some View {
    NavigationStack {
      
      Group {
        if groupingType == .none {
          if displayType == .gallery {
            MyItemStandardGallery(searchText: searchText)
          }
          if displayType == .list {
            MyItemStandardList(searchText: searchText)
          }
        }
        
        if groupingType == .category {
          if displayType == .gallery {
            MyItemCategoryGallery(searchText: searchText)
          }
          if displayType == .list {
            MyItemCategoryList(searchText: searchText)
          }
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
          HStack(spacing: 12) {
            MyItemViewDisplaySettings()
            Button {
              isEditorPresented.toggle()
            } label: {
              Label("追加", systemImage: "plus")
            }
          }
        }
      }
    }
  }
}

enum DisplayType: String, CaseIterable {
  case gallery
  case list
  
  var name: String {
    switch self {
    case .gallery: return "ギャラリー"
    case .list: return "リスト"
    }
  }
  
  var icon: String {
    switch self {
    case .gallery: return "square.grid.3x3"
    case .list: return "list.dash"
    }
  }
}

enum GroupingType: String, CaseIterable {
  case none
  case category
  
  var name: String {
    switch self {
    case .none: return "なし"
    case .category: return "カテゴリー"
    }
  }
}

enum ItemSortOrder: String, CaseIterable {
  case reverse
  case forward
  
  var value: SortOrder {
    switch self {
    case .reverse: return .reverse
    case .forward: return .forward
    }
  }
  
  var name: String {
    switch self {
    case .reverse: return "新しい順"
    case .forward: return "古い順"
    }
  }
}


#Preview {
  MyItemView()
}
