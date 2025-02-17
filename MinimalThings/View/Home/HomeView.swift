//
//  HomeView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

struct HomeView: View {
  @Query var categories: [ItemCategory]
  @Query var items: [Item]
  
    var body: some View {
      HomeCategoryList()
    }
}

#Preview {
    HomeView()
    .modelContainer(PreviewModelContainer.container)
}
