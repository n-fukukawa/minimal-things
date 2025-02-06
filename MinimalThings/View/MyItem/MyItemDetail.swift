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
    VStack {
      Image("turtlerock")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: .infinity)
      
      Text(item.name)
      
      Spacer()
    }
  }
}

#Preview {
  let item = Item(name: "item name", status: .owned)
  return MyItemDetail(item: item)
}
