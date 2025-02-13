//
//  WantedItemDetailSpecView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/13.
//

import SwiftUI

struct WantedItemDetailSpecView: View {
  let item: Item
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("メーカー")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          Text(item.brand ?? "ー")
            .font(.subheadline)
          Spacer()
        }
        Rectangle()
          .fill(Color(UIColor.systemGray3))
          .opacity(0.5)
          .frame(height: 1)
      }
      .padding(.top, 4)
      .padding(.bottom, 8)
      
      VStack {
        HStack {
          Text("サイズ")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          Text(item.size ?? "ー")
            .font(.subheadline)
          Spacer()
        }
        Rectangle()
          .fill(Color(UIColor.systemGray3))
          .opacity(0.5)
          .frame(height: 1)
      }
      .padding(.bottom, 8)
      
      VStack {
        HStack {
          Text("重さ")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          Text(getWeightText(item: item))
            .font(.subheadline)
          Spacer()
        }
        Rectangle()
          .fill(Color(UIColor.systemGray3))
          .opacity(0.5)
          .frame(height: 1)
      }
      .padding(.bottom, 8)
      
      VStack {
        HStack {
          Text("カラー")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          Rectangle()
            .fill(item.color?.color ?? Color(UIColor.systemBackground))
            .frame(width: 16, height: 16)
            .border(Color.gray, width: 1)
          Spacer()
        }
        Rectangle()
          .fill(Color(UIColor.systemGray3))
          .opacity(0.5)
          .frame(height: 1)
      }
      .padding(.bottom, 8)
    }
  }
  
  private func getWeightText(item: Item) -> String {
    if let gram = item.gram {
      if item.weightUnit == Item.WeightUnit.g {
        return "\(gram)g"
      } else {
        return "\(Float(gram) / 1000)kg"
      }
    } else {
      return "ー"
    }
  }
}

#Preview {
  WantedItemDetailSpecView(item: Item(name: "itemname", status: Item.ItemStatus.owned.rawValue))
}
