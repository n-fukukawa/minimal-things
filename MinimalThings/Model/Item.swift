//
//  Item.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/05.
//

import Foundation
import SwiftUI
import PhotosUI
import SwiftData

@Model
final class Item {
  var name: String
  var comment: String?
  var category: ItemCategory?
  
  var status: ItemStatus.RawValue
  
  var images: [Data] = []
  
  var maker: String?
  var size:  String?
  var gram: Int?
  var weightUnit: WeightUnit?
  var color: ItemColor?
  
  var price: Int?
  var purchasedAt: Date?
  var shop: String?
  var url: String?
  
  var reasonWhyDiscard: String?
  
  var createdAt: Date?
  var updatedAt: Date?
  
  init(name: String, status: ItemStatus.RawValue) {
    self.name = name
    self.status = status
  }
}

extension Item {
  enum ItemStatus: Int, CaseIterable, Codable {
    case owned = 1
    case wanted = 2
    case discarded = 3
  }
}

extension Item {
  enum WeightUnit: String, CaseIterable, Codable {
    case g = "g"
    case kg = "kg"
  }
}

extension Item {
  enum ItemColor: String, CaseIterable, Codable {
    case black
    case white
    case gray
    case beige
    case brown
    case red
    case orange
    case yellow
    case yellowGreen
    case green
    case sky
    case blue
    case indigo
    case purple
    case peach
    case pink
    
    var text: String {
      switch self {
      case .black: return "黒色"
      case .white: return "白色"
      case .gray: return "グレー"
      case .beige: return "ベージュ"
      case .brown: return "茶色"
      case .red: return "赤色"
      case .orange: return "オレンジ"
      case .yellow: return "黄色"
      case .yellowGreen: return "黄緑色"
      case .green: return "緑色"
      case .sky: return "水色"
      case .blue: return "青色"
      case .indigo: return "インディゴ"
      case .purple: return "紫色"
      case .peach: return "桃色"
      case .pink: return "ビビッドピンク"
      }
    }
    
    var color: Color {
      switch self {
      case .black: return Color.black
      case .white: return Color.white
      case .gray: return Color.gray
      case .beige: return Color(red: 238/255, green: 220/255, blue: 179/255)
      case .brown: return Color(red: 135/255, green: 92/255, blue: 68/255)
      case .red: return Color(red: 237/255, green: 26/255, blue: 61/255)
      case .orange: return Color(red: 255/255, green: 194/255, blue: 14/255)
      case .yellow: return Color(red: 255/255, green: 239/255, blue: 108/255)
      case .yellowGreen: return Color(red: 184/255, green: 210/255, blue: 0)
      case .green: return Color(red: 62/255, green: 179/255, blue: 112/255)
      case .sky: return Color(red: 188/255, green: 226/255, blue: 232/255)
      case .blue: return Color(red: 0, green: 103/255, blue: 192/255)
      case .indigo: return Color.indigo
      case .purple: return Color(red: 136/255, green: 72/255, blue: 152/255)
      case .peach: return Color(red: 245/255, green: 178/255, blue: 178/255)
      case .pink: return Color.pink
      }
    }
  }
}

extension Item {
  static func predicate(status: ItemStatus, searchText: String) -> Predicate<Item> {
    let statusRawValue = status.rawValue
    return #Predicate<Item> { item in
      item.status == statusRawValue &&
      (searchText.isEmpty || item.name.contains(searchText))
    }
  }
}

extension Item {
  static func fetchByCategory(status: ItemStatus, category: ItemCategory?, searchText: String) -> Predicate<Item> {
    let statusRawValue = status.rawValue
    
    if let categoryName = category?.name {
      return #Predicate<Item> { item in
        item.status == statusRawValue &&
        item.category?.name == categoryName &&
        (searchText.isEmpty || item.name.contains(searchText))
      }
    } else {
      return #Predicate<Item> { item in
        item.status == statusRawValue &&
        item.category == nil &&
        (searchText.isEmpty || item.name.contains(searchText))
      }
    }
  }
}
