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
  
  @State private var selectedPhotos: [PhotosPickerItem] = []
  @State private var selectedPhotoData: [PhotoData] = []
  
  var body: some View {
    VStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          Section {
            MyItemEditorPhotoField(photosPickerItem: $selectedPhotos, photoDataArray: $selectedPhotoData)
          }
          .onAppear {
            if let item {
              item.images.forEach({ imageData in
                let photoData = PhotoData(id: UUID().uuidString, stored: true, fixed: true, data: imageData)
                selectedPhotoData.append(photoData)
              })
            }
          }
        }
      }
      
      Button {
        if let item {
          // 編集処理
          item.images = selectedPhotoData.map({ $0.data })
        } else {
          // 新規作成
          let newItem = Item(name: "new", status: .owned)
          newItem.images = selectedPhotoData.map({ $0.data })
          modelContext.insert(newItem)
        }
        dismissAction()
      } label: {
        Text("追加")
      }
    }
  }
}

#Preview {
  MyItemEditor(dismissAction: {})
    .modelContainer(for: [Item.self], inMemory: true)
}
