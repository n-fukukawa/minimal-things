////
////  CameraPicker.swift
////  MinimalThings
////
////  Created by Naruki Fukukawa on 2025/02/27.
////
//
//import SwiftUI
//import AVFoundation
//
//struct CameraPicker: View {
//  @Environment(\.dismiss) var dismiss
//  let onAfterPick: () -> Void
//  @Binding var image: UIImage?
//  @State private var showCamera = false
//  @State private var available = false
//  @State private var showAlert = false
//  
//  var body: some View {
//    NavigationView {
//      VStack {
//        if !available {
//          VStack (spacing: 10) {
//            Text("Camera access is not permitted.")
//            Button("Open settings") { openSettings() }
//          }
//        }
//        
//        if available {
//          Rectangle()
//            .fill(.clear)
//            .frame(height: 1)
//
//        }
//      }
//    }
//    .alert("Camera access is not permitted.", isPresented: $showAlert) {
//      Button("Cancel") { showAlert = false }
//      Button("Open settings") { openSettings() }
//    } message: {
//      Text("Please allow camera access in iOS settings.")
//    }
//    .onAppear {
//      checkCamera()
//    }
//    .onChange(of: image) { _, newValue in
//      if newValue != nil {
//        onAfterPick()
//      }
//    }
//    .onChange(of: showCamera) { _, newValue in
//      if !newValue {
//        dismiss()
//      }
//    }
//  }
//  
//  private func checkCamera() {
//    let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//    
//    if status == .notDetermined {
//      AVCaptureDevice.requestAccess(for: .video) { (granted: Bool) in
//          DispatchQueue.main.async {
//            if granted {
//              showCamera = true
//              available = true
//            }
//          }
//      }
//    } else if status == AVAuthorizationStatus.authorized {
//      showCamera = true
//      available = true
//    } else {
//      AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
//        if (granted == false) {
//          showAlert = true
//          available = false
//          print("not available")
//        }
//      })
//    }
//  }
//  
//
//}
//
//
//
//#Preview {
//  @Previewable @State var image: UIImage?
//  CameraPicker(onAfterPick: {}, image: $image)
//}
