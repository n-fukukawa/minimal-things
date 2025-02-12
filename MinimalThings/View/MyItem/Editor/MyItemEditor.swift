//
//  MyItemEditor.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/07.
//

import SwiftUI
import PhotosUI

struct MyItemEditor: View {
  @Environment(\.modelContext) var modelContext
  var item: Item?
  var dismissAction: () -> Void
  
  @FocusState private var focused: Bool
  
  @State private var activeTab: Int = 1
  
  @State private var selectedPhotos: [PhotosPickerItem] = []
  @State private var selectedPhotoData: [PhotoData] = []
  
  @State private var name: String = ""
  @State private var category: ItemCategory?
  @State private var memo: String = ""
  
  @State private var brand: String = ""
  @State private var size: String = ""
  @State private var weightInput: String = ""
  @State private var weightUnit: Item.WeightUnit = Item.WeightUnit.g
  
  @State private var color: Item.ItemColor?
  @State private var priceInput: String = ""
  @State private var purchasedAt: Date?
  @State private var shop: String = ""
  @State private var url: String = ""
  
  var body: some View {
    VStack {
      VStack(spacing: 20) {
        MyItemEditorTabBar(activeTab: $activeTab)
        
        ScrollView(.vertical, showsIndicators: false) {
          if activeTab == 1 {
            MyItemEditorPhotoSection(
              photosPickerItem: $selectedPhotos,
              photoDataArray: $selectedPhotoData
            )
            .padding(.bottom)
            
            MyItemEditorFoundationSection(
              name: $name,
              category: $category,
              memo: $memo,
              focused: $focused
            )
          }
          
          if activeTab == 2 {
            MyItemEditorDetailSection(
              focused: $focused,
              brand: $brand,
              size: $size,
              weightInput: $weightInput,
              weightUnit: $weightUnit,
              color: $color,
              priceInput: $priceInput,
              purchasedAt: $purchasedAt,
              shop: $shop,
              url: $url
            )
          }
        }
      }
    }
    .padding()
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button {
          if let item {
            updateItem(item: item)
          } else {
            insertItem()
          }
          dismissAction()
        } label: {
          Text(item == nil ? "作成" : "保存")
        }
      }
      ToolbarItemGroup(placement: .keyboard) {
        Spacer()
        Button("閉じる") {
          focused = false
        }
      }
    }
    .onAppear {
      if let item {
        setDefaultValues(item: item)
      }
    }
  }
  
  // 初期値設定
  private func setDefaultValues(item: Item) {
    item.images.forEach({ imageData in
      let photoData = PhotoData(id: UUID().uuidString, stored: true, fixed: true, data: imageData)
      selectedPhotoData.append(photoData)
    })
    name = item.name
    category = item.category
    memo = item.memo ?? ""
    brand = item.brand ?? ""
    weightUnit = item.weightUnit ?? Item.WeightUnit.g
    if let gram = item.gram {
      if item.weightUnit == Item.WeightUnit.kg {
        weightInput = String(Float(gram / 1000))
      } else {
        weightInput = String(gram)
      }
    } else {
      weightInput = ""
    }
    color = item.color
    if let price = item.price {
      priceInput = String(price)
    } else {
      priceInput = ""
    }
    purchasedAt = item.purchasedAt
    shop = item.shop ?? ""
    url = item.url ?? ""
  }
  
  // 編集処理
  private func updateItem(item: Item) {
    item.images = selectedPhotoData.map({ $0.data })
    item.name = name
    item.category = category
    item.memo = memo.isEmpty ? nil : memo
    item.brand = brand.isEmpty ? nil : brand
    item.weightUnit = weightUnit
    item.gram = getGramValue()
    item.color = color
    item.price = priceInput.isEmpty ? nil : Int(priceInput)
    item.purchasedAt = purchasedAt
    item.shop = shop.isEmpty ? nil : shop
    item.url = url
    item.updatedAt = Date()
  }
  // 新規作成
  private func insertItem() {
    let newItem = Item(name: name, status: Item.ItemStatus.owned.rawValue)
    newItem.images = selectedPhotoData.map({ $0.data })
    newItem.category = category
    newItem.memo = memo.isEmpty ? nil : memo
    newItem.brand = brand.isEmpty ? nil : brand
    newItem.weightUnit = weightUnit
    newItem.gram = getGramValue()
    newItem.color = color
    newItem.price = priceInput.isEmpty ? nil : Int(priceInput)
    newItem.purchasedAt = purchasedAt
    newItem.shop = shop.isEmpty ? nil : shop
    newItem.url = url.isEmpty ? nil : url
    newItem.createdAt = Date()
    newItem.updatedAt = Date()
    modelContext.insert(newItem)
  }
  
  // 重さの整形
  private func getGramValue() -> Int? {
    if let floatWeight = Float(weightInput) {
      if weightUnit == Item.WeightUnit.g {
        return Int(floor(floatWeight))
      } else {
        return Int(floor(floatWeight * 1000))
      }
    } else {
      return nil
    }
  }
}

#Preview {
  MyItemEditor(dismissAction: {})
    .modelContainer(for: [Item.self], inMemory: true)
}
