//
//  PhotoData.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import Foundation

final class PhotoData {
  var id: String
  var stored: Bool
  var fixed: Bool
  var data: Data
  
  init(id: String, stored: Bool, fixed: Bool, data: Data) {
    self.id = id
    self.stored = stored
    self.fixed = fixed
    self.data = data
  }
}
