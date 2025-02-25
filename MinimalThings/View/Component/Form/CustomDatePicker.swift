//
//  CustomDatePicker.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/25.
//

import SwiftUI

struct CustomDatePicker: View {
  @Binding var dateBinding: Date?
  let label: String
  
  @State private var isPresented: Bool = false
  @State private var dateState: Date = Date()
  
  var body: some View {
    HStack {
      if let date = dateBinding {
        HStack {
          Button {
            isPresented.toggle()
          } label: {
            HStack {
              Text("\(label):")
              Text(date, format: Date.FormatStyle(date: .numeric, time: .omitted))
            }
          }
          
          Button {
            dateBinding = nil
          } label: {
            Image(systemName: "xmark")
              .font(.subheadline)
          }
        }
      } else {
        Button {
          isPresented.toggle()
        } label: {
          HStack {
            Text("\(label)を選択")
            Image(systemName: "chevron.down")
          }
        }
      }
    }
    .tint(.foregroundSecondary)
    .padding(12)
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(.containerDivider, lineWidth: 1)
    )
    .sheet(isPresented: $isPresented) {
      NavigationStack {
        DatePicker(
          "Start Date",
          selection: $dateState,
          displayedComponents: [.date]
        )
        .labelsHidden()
        .datePickerStyle(.wheel)
        
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("キャンセル") {
              isPresented.toggle()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            Button("今日") {
              dateState = Date()
            }
          }
          ToolbarItem(placement: .primaryAction) {
            Button("完了") {
              isPresented.toggle()
              dateBinding = dateState
            }
          }
        }
      }
      .presentationDetents([.height(280)])
      .tint(.foregroundPrimary)
    }
    .onChange(of: isPresented) { _, newValue in
      if newValue {
        dateState = dateBinding ?? Date()
      }
    }
  }
}

#Preview {
  @Previewable @State var date: Date? = nil
  return CustomDatePicker(dateBinding: $date, label: "日付")
}
