//
//  MyItemEditorPhotoHome.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import SwiftUI
import PhotosUI

struct MyItemEditorPhotoHome: View {
  @Binding var photosPickerItem: [PhotosPickerItem]
  @Binding var photoDataArray: [PhotoData]
  var onDismiss: () -> Void
  
  var body: some View {
    VStack {
      TabView {
        MyItemEditorPhotoPicker(photosPickerItem: $photosPickerItem, photoDataArray: $photoDataArray)
          .tabItem {
            Image(systemName: "photo.on.rectangle.angled")
            Text("アルバム")
          }
      }

    }
  }
}

#Preview {
  MyItemEditorPhotoHome(photosPickerItem: .constant([]), photoDataArray: .constant([]), onDismiss: {})
    .modelContainer(for: [Item.self], inMemory: true)
}
