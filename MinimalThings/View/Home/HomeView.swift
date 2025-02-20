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
  
    var body: some View {
      ZStack {
        Rectangle()
          .fill(.backgroundPrimary)
          .ignoresSafeArea(.all)
        
        VStack {
          HStack {
            Text("My Items")
              .font(.title)
            Spacer()
            Button {
              
            } label: {
              Image(systemName: "plus")
                .font(.title2)
                .foregroundStyle(.foregroundPrimary)
            }
          }
          .frame(height: 50)
          .padding(.top, 30)
          .padding(.horizontal, 30)
          
          HomeCategoryList()
          
          Rectangle()
            .fill(.clear)
            .frame(height: 60)
        }
      }
    }
}

#Preview {
    HomeView()
    .modelContainer(PreviewModelContainer.container)
}
