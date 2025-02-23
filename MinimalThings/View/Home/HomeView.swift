//
//  HomeView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI
import SwiftData

let SCREEN_MAXX = UIScreen.main.bounds.width
let SCREEN_MIDX = UIScreen.main.bounds.width / 2

struct HomeView: View {
  @Query var categories: [ItemCategory]
  @Query var items: [Item]
  
  @State private var isItemEditorPresented: Bool = false
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.backgroundPrimary)
        .ignoresSafeArea(.all)
      
      VStack {
        header
        HomeCategoryList()
        Rectangle()
          .fill(.clear)
          .frame(height: 60)
      }
    }
  }
  
  private var header: some View {
    HStack(spacing: 20) {
      Text("My Items")
        .font(.title)
      
      Spacer()
      
      Button {
        isItemEditorPresented = true
      } label: {
        Image(systemName: "plus")
          .font(.title2)
          .foregroundStyle(.foregroundSecondary)
      }
      .sheet(isPresented: $isItemEditorPresented) {
        ItemEditor()
      }
      
      NavigationLink {
        SettingList()
      } label: {
        Image(systemName: "gearshape.fill")
          .font(.title2)
          .foregroundStyle(.foregroundTertiary)
      }
    }
    .frame(height: 50)
    .padding(.top, 30)
    .padding(.horizontal, 30)
  }
}

#Preview {
  HomeView()
    .modelContainer(PreviewModelContainer.container)
}
