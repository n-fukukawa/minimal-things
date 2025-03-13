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
  @State private var isPresented: Bool = false
  @State private var showCamera: Bool = false
  @State private var showAlert: Bool = false
  @State private var cameraImage: UIImage? = nil
  
  var body: some View {
    VStack {
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
            photoDataState = UIImage(data: data)?
              .preparingThumbnail(of: CGSize(width: 1000, height: 1000))?
              .jpegData(compressionQuality: 0.5)
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
      
      HStack {
        Spacer()
        Button { showCamera = false } label: {
          VStack(spacing: 4) {
            Image(systemName: "photo").font(.title3)
            Text("Album").font(.caption)
          }
          .tint(.accentColor)
        }
        Spacer()
        Button {
          let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
          
          if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (granted: Bool) in
                if granted {
                  DispatchQueue.main.async {
                    showCamera = true
                  }
                }
            }
          } else if status == AVAuthorizationStatus.authorized {
            showCamera = true
          } else {
            showAlert = true
          }
        } label: {
          VStack(spacing: 4) {
            Image(systemName: "camera").font(.title3)
            Text("Camera").font(.caption)
          }
          .tint(.foregroundTertiary)
        }
        Spacer()
      }
      .padding(.vertical, 10)
    }
    .fullScreenCover(isPresented: $showCamera) {
      ImagePickerView(image: $cameraImage, isPresented: $showCamera)
    }
    .onChange(of: isPresented) { _, newValue in
      showCamera = newValue
    }
    .alert("Camera access is not permitted.", isPresented: $showAlert) {
      Button("Cancel") { showAlert = false }
      Button("Open settings") { openSettings() }
    } message: {
      Text("Please allow camera access in iOS settings.")
    }
    .onChange(of: cameraImage) { _, newValue in
      if newValue != nil {
        photoData = cameraImage?
          .preparingThumbnail(of: CGSize(width: 1000, height: 1000))?
          .jpegData(compressionQuality: 0.5)
      }
    }
  }
  
  private func openSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString ) else {
      return
    }
    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
  }
}

#Preview {
  @Previewable @State var photoData: Data? = nil
  return PhotoPicker(photoData: $photoData)
}
