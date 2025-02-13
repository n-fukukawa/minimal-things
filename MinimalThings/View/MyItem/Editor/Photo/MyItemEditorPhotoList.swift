//
//  MyItemEditorPhotoList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/08.
//

import SwiftUI
import PhotosUI

struct MyItemEditorPhotoList: View {
  @Binding var photoDataArray: [PhotoData]
  
  var body: some View {
    let photoDataArrayIndices = photoDataArray.indices
    
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(0..<5, id: \.self) { index in
          if photoDataArrayIndices.contains(index),
              let uiImage = UIImage(data: photoDataArray[index].data)
          {
            Image(uiImage: uiImage)
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
              .border(Color(UIColor.systemGray3), width: 1)
          } else {
            Rectangle()
              .fill(index == photoDataArrayIndices.count
                    ? Color(UIColor.systemGray4)
                    : Color(UIColor.systemGray6)
              )
              .frame(width: 80, height: 80)
          }
        }
      }
    }
  }
}

#Preview {
  MyItemEditorPhotoList(photoDataArray: .constant([]))
    .modelContainer(for: [Item.self], inMemory: true)
}
