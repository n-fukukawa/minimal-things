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
  @Query(sort: \ItemCategory.sortOrder) var categories: [ItemCategory]
  
  @State private var isItemEditorPresented: Bool = false
  @State private var activeCategoryIndex: Int = 0
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.backgroundPrimary)
        .ignoresSafeArea(.all)
      
      VStack(spacing: 0) {
        header
        HomeCategoryList(
          categories: categories,
          activeCategoryIndex: $activeCategoryIndex
        )
        BannerContentView()
      }
    }
  }
  
  private var header: some View {
    HStack(spacing: 20) {
      Text("Home Title")
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
        NavigationStack {
          ItemEditor(defaultCategory: categories[safe: activeCategoryIndex] )
        }
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
    .environmentObject(Snackbar())
}
