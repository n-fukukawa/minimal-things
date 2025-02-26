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
  // Album
  @State private var photosPickerItem: PhotosPickerItem? = nil
  @State private var photoDataState: Data? = nil
  // Camera
  @State private var cameraImage: UIImage? = nil
  
  var body: some View {
    TabView {
      Tab("Album", systemImage: "photo") {
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
      }
      
      Tab("Camera", systemImage: "camera") {
        CameraPicker(
          onAfterPick: {
            photoData = cameraImage?.jpegData(compressionQuality: 1.0)
            dismiss()
          },
          image: $cameraImage)
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button("Cancel") {
          photosPickerItem = nil
          dismiss()
        }
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button("Done") {
          photoData = photoDataState
          photosPickerItem = nil
          dismiss()
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var photoData: Data? = nil
  return PhotoPicker(photoData: $photoData)
}
