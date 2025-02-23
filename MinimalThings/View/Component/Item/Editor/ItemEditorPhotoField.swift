//
//  ItemEditorPhotoField.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI
import PhotosUI

struct ItemEditorPhotoField: View {
  @Binding var photoData: Data?
  @State private var isPickerPresented: Bool = false
  @State private var isEditorPresented: Bool = false
  
  var body: some View {
    pickerButton
      .sheet(isPresented: $isPickerPresented) {
        NavigationStack {
          PhotoPicker(photoData: $photoData)
        }
      }
      .sheet(isPresented: $isEditorPresented) {
        NavigationStack {
          PhotoEditor(photoData: $photoData)
        }
      }
  }
  
  private var pickerButton: some View {
    Button {
      if photoData == nil {
        isPickerPresented = true
        isEditorPresented = false
      } else {
        isPickerPresented = false
        isEditorPresented = true
      }
    } label: {
      Group {
        if let data = photoData, let uiImage = UIImage(data: data) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
        } else {
          Image(systemName: "camera")
            .font(.largeTitle)
            .foregroundStyle(.foregroundTertiary)
        }
      }
      .frame(width: 80, height: 80)
      .background(
        Rectangle()
          .fill(Color.shadow.opacity(0.5))
          .stroke(.foregroundTertiary.opacity(0.5))
      )
    }
  }
}

#Preview {
  @Previewable @State var photoData: Data? = nil
  return ItemEditorPhotoField(photoData: $photoData)
}
