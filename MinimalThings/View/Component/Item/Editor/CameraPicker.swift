//
//  CameraPicker.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/27.
//

import SwiftUI

struct CameraPicker: View {
  @Environment(\.dismiss) var dismiss
  let onAfterPick: () -> Void
  @Binding var image: UIImage?
  @State private var showCamera = true
  
  var body: some View {
    NavigationView {
      Rectangle()
        .fill(.clear)
        .frame(height: 1)
        .fullScreenCover(isPresented: self.$showCamera) {
          ImagePickerView(image: $image, isPresented: $showCamera)
        }
    }
    .onChange(of: image) { _, newValue in
      if newValue != nil {
        onAfterPick()
      }
    }
    .onChange(of: showCamera) { _, newValue in
      if !newValue {
        dismiss()
      }
    }
  }
}

#Preview {
  @Previewable @State var image: UIImage?
  CameraPicker(onAfterPick: {}, image: $image)
}
