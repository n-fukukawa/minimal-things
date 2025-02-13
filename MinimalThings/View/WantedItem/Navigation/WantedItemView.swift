//
//  WantedItemView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemView: View {
  @State private var searchText: String = ""
  @State private var isEditorPresented: Bool = false
  
  var body: some View {
    NavigationStack {
      Group {
        WantedItemList(searchText: searchText)
      }
      .searchable(text: $searchText)
      .sheet(isPresented: $isEditorPresented) {
        NavigationStack {
          WantedItemEditor(dismissAction: { isEditorPresented = false })
            .navigationTitle("ほしい物-新規作成")
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
          MyItemViewDisplaySettings()
          Label("追加", systemImage: "plus")
            .onTapGesture {
              isEditorPresented.toggle()
            }
        }
      }
    }
  }
}

#Preview {
  WantedItemView()
}
