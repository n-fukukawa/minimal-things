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
  let formatter = DateFormatter()
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("購入日")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          if let date = item.purchasedAt {
            Text(formatter.string(from: date))
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
          Text("URL")
            .font(.subheadline)
            .frame(width: 80, alignment: .leading)
            .padding(.leading, 8)
          if let url = item.url {
            HStack {
              Link(url, destination: URL(string: url)!)
                .font(.subheadline)
                .foregroundStyle(.blue)
                .lineLimit(1)
                .truncationMode(.tail)
                .textSelection(.enabled)
              ShareLink("", item: URL(string: url)!)
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
    .onAppear {
      formatter.locale = Locale(identifier: "ja_JP")
      formatter.dateFormat = "yyyy/MM/dd"
      formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
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
