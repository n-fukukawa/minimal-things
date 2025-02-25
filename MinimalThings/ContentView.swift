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
    NavigationStack {
      HomeView()
    }
  }
}

#Preview {
  return ContentView()
    .modelContainer(PreviewModelContainer.container)
    .environment(\.locale, .init(identifier: "en"))
}

#Preview {
  return ContentView()
    .modelContainer(PreviewModelContainer.container)
    .environment(\.locale, .init(identifier: "ja"))
}
