//
//  MyItemEditorPurchaseDateField.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemEditorPurchaseDateField: View {
  @Binding var purchasedAt: Date?
  
  @State private var isPurchasedAtPresented: Bool = false
  @State private var purchasedAtState: Date = Date()

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("購入日")
        .font(.subheadline)
      
      HStack {
        if let date = purchasedAt {
          HStack {
            Button {
              isPurchasedAtPresented.toggle()
            } label: {
              Text(date, format: Date.FormatStyle(date: .numeric, time: .omitted))
            }
            
            Button {
              purchasedAt = nil
            } label: {
              Image(systemName: "xmark")
                .font(.subheadline)
            }
          }
        } else {
          Button {
            isPurchasedAtPresented.toggle()
          } label: {
            Text("購入日を選択する")
          }
        }
      }
      
    }
    .sheet(isPresented: $isPurchasedAtPresented) {
      NavigationStack {
        DatePicker(
          "",
          selection: $purchasedAtState,
          displayedComponents: [.date]
        )
        .labelsHidden()
        .datePickerStyle(.wheel)
        
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("キャンセル") {
              isPurchasedAtPresented.toggle()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            Button("今日") {
              purchasedAtState = Date()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            Button("完了") {
              isPurchasedAtPresented.toggle()
              purchasedAt = purchasedAtState
            }
          }
        }
      }
      .presentationDetents([.height(280)])
    }
    .onChange(of: isPurchasedAtPresented) { _, newValue in
      if newValue {
        purchasedAtState = purchasedAt ?? Date()
      }
    }
  }
}

#Preview {
  MyItemEditorPurchaseDateField(purchasedAt: .constant(nil))
}
