//
//  ContentView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var categories: [ItemCategory]
  @Query private var items: [Item]
  
  var body: some View {
    TabView {
      MyItemView()
        .tabItem {
          Image(systemName: "house")
          Text("ホーム")
        }
    }
    .onAppear {
      createCategoriesIfNeed()
      createItemsIfNeed()
    }
  }
  
  func createCategoriesIfNeed() {
    if categories.isEmpty {
      let categoryNames = [
        "家電",
        "家具",
        "衣類",
        "日用品",
        "美容用品",
        "未分類",
      ]
      categoryNames.forEach({ name in
        modelContext.insert(ItemCategory(name: name))
      })
    }
  }
  
  func createItemsIfNeed() {
    if items.isEmpty {
      let item = Item(name: "急速充電ができるモバイルバッテリー", status: .owned)
      item.images = [Data()]
      item.category = categories.first
      item.memo = """
      【商品の特長】
      ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
      USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
      2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
      """
      item.brand = "無印良品"
      item.size = "奥行：3.32cm　幅：7.83cm　高さ：8.70cm　重さ：0.26kg"
      item.gram = 280
      item.weightUnit = Item.WeightUnit.g
      item.color = Item.ItemColor.white
      item.purchasedAt = Date()
      item.price = 3780
      item.shop = "無印良品オンラインショップ"
      item.url = "https://www.muji.com/jp/ja/store/cmdty/section/T20213"
      modelContext.insert(item)
      
      let item2 = Item(name: "急速充電ができるモバイルバッテリー", status: .owned)
      item2.images = [Data()]
      item2.category = nil
      item2.memo = """
      【商品の特長】
      ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
      USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
      2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
      """
      item2.brand = "無印良品"
      item2.size = "奥行：3.32cm　幅：7.83cm　高さ：8.70cm　重さ：0.26kg"
      item2.gram = 280
      item2.weightUnit = Item.WeightUnit.g
      item2.color = Item.ItemColor.white
      item2.purchasedAt = Date()
      item2.price = 3780
      item2.shop = "無印良品オンラインショップ"
      item2.url = "https://www.muji.com/jp/ja/store/cmdty/section/T20213"
      modelContext.insert(item2)
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
