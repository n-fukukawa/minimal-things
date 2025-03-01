//
//  SnackbarView.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/03/01.
//

import SwiftUI

final class Snackbar: ObservableObject {
  @Published var show: Bool
  @Published var status: Status
  @Published var message: String
  
  init() {
    self.show = false
    self.status = .success
    self.message = ""
  }
  
  func success(message: String) {
    self.show = true
    self.status = .success
    self.message = message
    self.close(duration: 3.0)
  }
  
  func error(message: String) {
    self.show = true
    self.status = .error
    self.message = message
    self.close(duration: 3.0)
  }
  
  func close(duration: Double) {
    Task {
      sleep(3)
      await MainActor.run {
        withAnimation {
          self.close()
        }
      }
    }
  }
  
  func close() {
    self.show = false
    self.message = ""
  }
  
}

extension Snackbar {
  enum Status {
    case success
    case error
  }
}

struct SnackbarView: View {
  @EnvironmentObject var snackbar: Snackbar
  
  var body: some View {
    HStack {
      Text(snackbar.message)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 50)
      Spacer()
      Button {
        snackbar.close()
      } label: {
        Image(systemName: "xmark")
      }
    }
    .padding(.horizontal)
    .foregroundStyle(snackbar.status == .error ? .snackbarErrorForeground : .snackbarSuccessForeground)
    .background(
      RoundedRectangle(cornerRadius: 3)
        .fill(snackbar.status == .error ? .snackbarErrorBackground : .snackbarSuccessBackground)
        .stroke(snackbar.status == .error ? .snackbarErrorForeground : .snackbarSuccessForeground)
        .shadow(color: .shadow, radius: 3, y: 2)
    )
    .opacity(snackbar.show ? 1 : 0)
    .offset(y: snackbar.show ? -50 : 100)
    .padding(20)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
  }
}

#Preview {
  SnackbarView()
}
