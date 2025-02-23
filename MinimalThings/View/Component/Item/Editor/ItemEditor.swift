//
//  ItemEditor.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI
import PhotosUI

struct ItemEditor: View {
  @Environment(\.dismiss) var dismiss
  let item: Item?
  @State var photoData: Data? = nil
  
  init(item: Item? = nil) {
    self.item = item
  }
  
  var body: some View {
    VStack {
      ItemEditorPhotoField(photoData: $photoData)
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button { dismiss() } label: {
          Image(systemName: "xmark")
        }
      }
    }
  }
}

#Preview {
  ItemEditor()
}
