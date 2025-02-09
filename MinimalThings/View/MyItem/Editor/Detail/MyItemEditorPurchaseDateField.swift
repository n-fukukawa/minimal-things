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
  
  let year = Calendar.current.component(.year, from: Date())
  let formatter = DateFormatter()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("購入日")
        .font(.subheadline)
      
      HStack {
        if let date = purchasedAt {
          HStack {
            Button {
              isPurchasedAtPresented.toggle()
            } label: {
              Text(formatter.string(from: date))
            }
            .padding(.leading)
            
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
            purchasedAt = Date()
          } label: {
            Text("購入日を選択する")
          }
          .padding(.leading)
        }
      }
      
    }
    .sheet(isPresented: $isPurchasedAtPresented) {
      VStack {
        HStack {
          Spacer()
          Button("完了") {
            isPurchasedAtPresented.toggle()
          }
        }
        DatePicker(
          "",
          selection: Binding<Date>(
            get: { self.purchasedAt ?? Date() },
            set: { self.purchasedAt = $0 }
          ),
          displayedComponents: [.date]
        )
        .labelsHidden()
        .datePickerStyle(.wheel)
      }
      .padding()
      .presentationDetents([.height(280)])
    }
    .onAppear {
      formatter.locale = Locale(identifier: "ja_JP")
      formatter.dateFormat = "yyyy年MM月dd日"
      formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    }
  }
}

#Preview {
  MyItemEditorPurchaseDateField(purchasedAt: .constant(nil))
}
