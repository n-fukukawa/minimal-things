//
//  MyItemDetail.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI

struct MyItemDetail: View {
  var item: Item
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        if item.images.count > 0,
           let uiImage = UIImage(data: item.images[0])
        {
          Image(uiImage: uiImage)
            .resizable()
            .frame(width: geometry.size.width, height: geometry.size.width)
            .scaledToFill()
        }
        
        Text(item.name)
        Text(item.category?.name ?? "").font(.caption)
        
        Spacer()
      }
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: .owned)
  return MyItemDetail(item: item)
}
