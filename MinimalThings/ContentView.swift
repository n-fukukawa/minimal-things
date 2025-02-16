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
    HomeView()
    .onAppear {
      createCategoriesIfNeed()
    }
    .onChange(of: categories) {
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
        "寝具",
        "調理用品",
        "美容用品",
      ]
      categoryNames.forEach({ name in
        modelContext.insert(ItemCategory(name: name))
      })
    }
  }
  
  func createItemsIfNeed() {
    if items.isEmpty {
      let item = Item(name: "急速充電ができるモバイルバッテリー", status: Item.ItemStatus.owned.rawValue)
      item.photo = Data()
      item.category = categories.first
      item.comment = """
      ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
      USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
      2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
      """
      item.maker = "無印良品"
      item.purchaseDate = Date()
      item.price = 3780
      item.url = "https://www.muji.com/jp/ja/store/cmdty/section/T20213"
      modelContext.insert(item)
      
      let item2 = Item(name: "急速充電ができるモバイルバッテリー", status: Item.ItemStatus.owned.rawValue)
      item2.photo = Data()
      item2.category = nil
      item2.comment = """
      【商品の特長】
      ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
      USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
      2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
      """
      item2.maker = "無印良品"
      item2.purchaseDate = Date()
      item2.price = 3780
      item2.url = "https://www.muji.com/jp/ja/store/cmdty/section/T20213"
      modelContext.insert(item2)
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
