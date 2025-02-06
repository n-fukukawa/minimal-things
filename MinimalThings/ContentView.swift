//
//  ContentView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    TabView {
      MyItemView()
        .tabItem { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Label@*/Text("Label")/*@END_MENU_TOKEN@*/ }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
