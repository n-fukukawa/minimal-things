//
//  ImagePickerView.swift
//  DeviceSample
//

import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  @Binding var isPresented: Bool
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.allowsEditing = true
    imagePicker.delegate = context.coordinator
    return imagePicker
  }
  
  func makeCoordinator() -> ImagePickerCoordinator {
    return ImagePickerCoordinator(image: $image, isPresented: $isPresented)
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
  }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var image: UIImage?
  @Binding var isPresented: Bool
  
  init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
    self._image = image
    self._isPresented = isPresented
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let editedImage = info[.editedImage] as? UIImage else { return }
    self.image = editedImage
    self.isPresented = false
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.isPresented = false
  }
}
