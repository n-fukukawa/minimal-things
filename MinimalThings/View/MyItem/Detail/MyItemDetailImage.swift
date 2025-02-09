//
//  MyItemDetailImage.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailImage: View {
  let item: Item
  let size: CGFloat
  
  var body: some View {
    if item.images.count > 0, let uiImage = UIImage(data: item.images[0]) {
      Image(uiImage: uiImage)
        .resizable()
        .frame(width: size, height: size)
        .scaledToFill()
    } else {
      Text(item.name)
        .font(.subheadline)
        .frame(width: size, height: size)
        .border(Color(UIColor.systemGray3), width: 1)
    }
  }
}

#Preview {
  let item = Item(name: "", status: .owned)
  return MyItemDetailImage(item: item, size: 100)
}
