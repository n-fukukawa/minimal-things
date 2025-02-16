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
  var status: ItemStatus.RawValue
  var name: String
  
  var photo: Data?
  
  var maker: String?
  var category: ItemCategory?
  var comment: String?
  
  var purchaseDate: Date?
  var price: Int?
  var url: String?
  
  var createdAt: Date?
  var updatedAt: Date?
  
  init(name: String, status: ItemStatus.RawValue = ItemStatus.owned.rawValue) {
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
  static func search(status: ItemStatus = .owned, searchText: String = "") -> Predicate<Item> {
    let statusRawValue = status.rawValue
    return #Predicate<Item> { item in
      item.status == statusRawValue &&
      (searchText.isEmpty || item.name.contains(searchText))
    }
  }
}

extension Item {
  static func fetchByCategory(status: ItemStatus = .owned, category: ItemCategory?, searchText: String = "") -> Predicate<Item> {
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
