//
//  MyItemDetailPurchaseInfoView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemDetailPurchaseInfoView: View {
  @Environment(\.openURL) private var openURL
  let item: Item
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("購入日")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          if let date = item.purchasedAt {
            Text(date, format: Date.FormatStyle(date: .numeric, time: .omitted))
              .font(.subheadline)
          } else {
            Text("ー")
              .font(.subheadline)
          }
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
          Text("購入場所")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          Text(item.shop ?? "ー")
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
          Text("価格")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          if let price = item.price {
            Text("\(price)円")
              .font(.subheadline)
          } else {
            Text("ー")
              .font(.subheadline)
          }
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
          Text("URL")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          if let urlString = item.url, let url = URL(string: urlString) {
            HStack {
              Link(urlString, destination: url)
                .font(.subheadline)
                .foregroundStyle(.blue)
                .lineLimit(1)
                .truncationMode(.tail)
                .textSelection(.enabled)
              ShareLink("", item: url)
            }
          } else {
            Text("ー")
              .font(.subheadline)
          }
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
}

#Preview {
  let item = Item(name: "itemname", status: .owned)
  item.purchasedAt = Date()
  item.shop = "sample store"
  item.url = "https://exampleexampleexampleexample.com"
  return MyItemDetailPurchaseInfoView(item: item)
}
