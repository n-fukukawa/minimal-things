//
//  HomeView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
      CategoryCard(category: nil)
    }
}

#Preview {
    HomeView()
    .modelContainer(for: Item.self, inMemory: true)
}
