//
//  ContentView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var categories: [ItemCategory]
  @Query private var items: [Item]
  
  var body: some View {
    ZStack {
      Rectangle().fill(.backgroundPrimary)
      .frame(height: .infinity)
      .ignoresSafeArea()
      
      HomeView()
    }
  }
}

#Preview {
  return ContentView()
    .modelContainer(PreviewModelContainer.container)
}
