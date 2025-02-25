//
//  PhotoEditor.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI

struct PhotoEditor: View {
  @Environment(\.dismiss) var dismiss
  @Binding var photoData: Data?
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        if let data = photoData, let uiImage = UIImage(data: data) {
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: SCREEN_MAXX, maxHeight: SCREEN_MAXX)
            .background(
              Rectangle()
                .fill(Color.shadow.opacity(0.5))
            )
        }
        
        Button {
          photoData = nil
          dismiss()
        } label: {
          Label(title: { Text("Delete") }, icon: { Image(systemName: "trash") })
            .font(.title3)
        }
        .tint(.foregroundPrimary)
        
        Spacer()
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Close") {
            dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var photoData: Data? = nil
  return PhotoEditor(photoData: $photoData)
}
