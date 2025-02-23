//
//  PhotoPicker.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
  @Environment(\.dismiss) var dismiss
  @Binding var photoData: Data?
  @State private var photosPickerItem: PhotosPickerItem? = nil
  @State private var photoDataState: Data? = nil
  
  var body: some View {
    TabView {
      Tab("アルバム", systemImage: "photo") {
        PhotosPicker(
          selection: $photosPickerItem,
          matching: .images,
          photoLibrary: .shared()
        ) {}
          .photosPickerStyle(.inline)
          .photosPickerDisabledCapabilities([.selectionActions])
          .photosPickerAccessoryVisibility(.hidden, edges: .all)
          .task(id: photosPickerItem) {
            if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
              photoDataState = data
            }
          }
          .toolbar {
            ToolbarItem(placement: .topBarLeading) {
              Button("キャンセル") {
                photosPickerItem = nil
                dismiss()
              }
            }
            ToolbarItem(placement: .topBarTrailing) {
              Button("完了") {
                photoData = photoDataState
                photosPickerItem = nil
                dismiss()
              }
            }
          }
      }
      
      // カメラ起動 インライン
      
    }
  }
}

#Preview {
  @Previewable @State var photoData: Data? = nil
  return PhotoPicker(photoData: $photoData)
}
