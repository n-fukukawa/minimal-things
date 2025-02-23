//
//  ItemCategory.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftData

@Model
final class ItemCategory {
  var name: String
  var sortOrder: Int = 0
  @Relationship(deleteRule: .nullify, inverse: \Item.category)
  var items = [Item]()
  
  init(name: String) {
    self.name = name
  }
}
