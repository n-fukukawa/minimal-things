//
//  SampleData.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.

import Foundation
import SwiftUI
import SwiftData

@MainActor
class PreviewModelContainer {
  static let container: ModelContainer = {
    do {
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(
        for: Item.self,
        configurations: config
      )
      
      for (index, category) in categories.enumerated() {
        category.sortOrder = index + 1
        container.mainContext.insert(category)
      }
      
      for (index, _item) in items.enumerated() {
        let item = Item(name: _item["name"] as! String)
        item.photo = ImageRenderer(content: Image("photo")).uiImage?.jpegData(compressionQuality: 1.0)
        item.category = categories[index % 2]
        item.maker = _item["maker"] as! String?
        item.comment = _item["comment"] as! String?
        item.purchaseDate = _item["purchaseDate"] as! Date?
        item.price = _item["price"] as! Float?
        item.url = _item["url"] as! String?
        item.sortOrder = index + 1
        container.mainContext.insert(item)
      }
      
      return container
    } catch {
      fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
  }()
  
  static let categories : [ItemCategory] = [
    ItemCategory(name: "クローゼット"),
    ItemCategory(name: "キッチン"),
    ItemCategory(name: "家具"),
    ItemCategory(name: "家電"),
    ItemCategory(name: "ガジェット"),
    ItemCategory(name: "寝具"),
    ItemCategory(name: "バスルーム"),
    ItemCategory(name: "趣味"),
  ]
  
  static let items: [Dictionary<String, Any?>] = [
    [
      "name": "急速充電ができるモバイルバッテリー",
      "maker": "無印良品",
      "comment":  """
        直接コンセントから充電できるモバイルバッテリーです。スマホ約2～3回分の充電ができます。
        【商品の特長】
        ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
        USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
        2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
      """,
      "purchaseDate": Date(),
      "price": Float(3990),
      "url": "https://www.muji.com/jp/ja/store/cmdty/detail/4550583825003",
      "categoryIndex": 2
    ],
    [
      "name": "ウレタンフォーム三層スポンジ３個入り／グレー",
      "maker": "無印良品",
      "comment":  """
        食器用・油汚れ用・シンク洗い用など用途でスポンジを使い分けたり、洗った際の色移りが気になりにくいグレー色を追加しました。
      """,
      "purchaseDate": nil,
      "price": Float(299),
      "url": nil,
      "categoryIndex": 0
    ],
    [
      "name": "電子ピアノ P-225",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
    [
      "name": "電子ピアノ P-525",
      "maker": "YAMAHA",
      "comment": nil,
      "purchaseDate": nil,
      "price": Float(59800),
      "url": "https://jp.yamaha.com/products/musical_instruments/pianos/p_series/p-225/index.html",
      "categoryIndex": 1
    ],
  ]
}
