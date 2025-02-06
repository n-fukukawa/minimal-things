//
//  MyItemView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/07.
//

import SwiftUI

struct MyItemView: View {
  var body: some View {
    NavigationStack {
      MyItemList()
        .navigationTitle("My Items")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  MyItemView()
}
