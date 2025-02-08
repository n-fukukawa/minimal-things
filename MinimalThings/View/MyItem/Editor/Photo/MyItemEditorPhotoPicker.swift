//
//  MyItemEditorPhotoPicker.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/07.
//

import SwiftUI
import PhotosUI

struct MyItemEditorPhotoPicker: View {
  @Binding var photosPickerItem: [PhotosPickerItem]
  @Binding var photoDataArray: [PhotoData]
  
  var gridItems = [GridItem(.adaptive(minimum: 100, maximum: 180))]
  
  var body: some View {
    let fixedPhotoDataCount = photoDataArray.filter({ $0.fixed }).count
    
    VStack {
      PhotosPicker(
        selection: $photosPickerItem,
        maxSelectionCount: 5 - fixedPhotoDataCount,
        selectionBehavior: .continuous,
        matching: .images,
        photoLibrary: .shared()
      ){
        Text("画像を選択")
      }
      
      .photosPickerStyle(.inline)
      .photosPickerDisabledCapabilities([.selectionActions])
      .photosPickerAccessoryVisibility(.hidden, edges: .all)
      .task(id: photosPickerItem) {
        for photo in photosPickerItem {
          if let id = photo.itemIdentifier,
             !photoDataArray.map({ $0.id }).contains(id) {
            if let data = try? await photo.loadTransferable(type: Data.self) {
              let newPhotoData = PhotoData(
                id: id,
                stored: false,
                fixed: false,
                data: data
              )
              if !photoDataArray.map({ $0.id }).contains(id) {
                photoDataArray.append(newPhotoData)
              }
            }
          }
        }
        // 「確定」または「選択」されているデータだけにする
        let ids = photosPickerItem.map({ $0.itemIdentifier })
        photoDataArray = photoDataArray.filter({ $0.fixed || ids.contains($0.id) })
      }
      
      MyItemEditorPhotoList(photoDataArray: $photoDataArray)
    }
    
  }
}

#Preview {
  MyItemEditorPhotoPicker(photosPickerItem: .constant([]),  photoDataArray: .constant([]))
    .modelContainer(for: [Item.self], inMemory: true)
}
