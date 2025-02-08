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
  var memo: String?
  var category: ItemCategory?
  
  var status: ItemStatus
  
  var images: [Data] = []
  
  var brand: String?
  var size:  String?
  var gram: Int?
  var weightUnit: WeightUnit?
  var color: ItemColor?
  
  var price: Int?
  var purchasedAt: Date?
  var shop: String?
  var url: String?
  
  var reasonWhyWant: String?
  var reasonWhyDiscard: String?
  
  var createdAt: Date?
  var updatedAt: Date?
  
  init(name: String, status: ItemStatus) {
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
    case red
    case blue
    
    var value: Color {
      switch self {
      case .black: return Color.black
      case .white: return Color.white
      case .red: return Color.red
      case .blue: return Color.blue
      }
    }
  }
}
