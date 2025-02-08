//
//  MyItemEditorPhotoSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import SwiftUI
import PhotosUI

struct MyItemEditorPhotoSection: View {
  @Binding var photosPickerItem: [PhotosPickerItem]
  @Binding var photoDataArray: [PhotoData]
  @State private var isPresented: Bool = false
  
  var body: some View {
    Group {
      if photoDataArray.count == 0 {
        Button {
          isPresented.toggle()
        } label: {
          Image(systemName: "camera.fill")
            .font(.title)
            .frame(width: 80, height: 80)
            .foregroundColor(Color(UIColor.systemGray2))
            .background(Color(UIColor.systemGray6))
            .border(Color(UIColor.systemGray3), width: 1)
        }
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(photoDataArray, id: \.self.id) { photoData in
              if let uiImage = UIImage(data: photoData.data) {
                Button {
                  isPresented.toggle()
                } label: {
                  Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFill()
                    .border(Color(UIColor.systemGray3), width: 1)
                }
              }
            }
            if photoDataArray.count < 5 {
              Button {
                isPresented.toggle()
              } label: {
                Image(systemName: "camera.fill")
                  .font(.title)
                  .frame(width: 80, height: 80)
                  .foregroundColor(Color(UIColor.systemGray2))
                  .background(Color(UIColor.systemGray6))
                  .border(Color(UIColor.systemGray3), width: 1)
              }
            }
          }
        }
      }
    }
    .sheet(isPresented: $isPresented) {
      NavigationStack {
        
        MyItemEditorPhotoHome(photosPickerItem: $photosPickerItem, photoDataArray: $photoDataArray, onDismiss: { isPresented = false} )
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button {
                isPresented = false
                // selectedPhotosのidを持つPhotoDataArray内の要素を削除
                photoDataArray = photoDataArray.filter({ $0.fixed })
                photosPickerItem = []
              } label: {
                Label("閉じる", systemImage: "xmark")
              }
            }
            ToolbarItem(placement: .primaryAction) {
              Button {
                isPresented = false
                photoDataArray.forEach({ photoData in
                  photoData.fixed = true
                })
                photosPickerItem = []
              } label: {
                Text("完了")
              }
            }
          }
      }
    }
  }
}

#Preview {
  MyItemEditorPhotoSection(photosPickerItem: .constant([]), photoDataArray: .constant([]))
    .modelContainer(for: [Item.self], inMemory: true)
}
