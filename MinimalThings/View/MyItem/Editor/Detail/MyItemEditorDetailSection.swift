//
//  MyItemEditorDetailSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemEditorDetailSection: View {
  @FocusState.Binding var focused: Bool
  @Binding var brand: String
  @Binding var size: String
  @Binding var weightInput: String
  @Binding var weightUnit: Item.WeightUnit
  
  @State private var isExpanded: Bool = false
  
    var body: some View {
      DisclosureGroup("詳細", isExpanded: $isExpanded) {
        
        VStack(alignment: .leading, spacing: 15) {
          VStack(alignment: .leading, spacing: 5) {
            Text("メーカー／ブランド")
              .font(.subheadline)
            TextField("例）無印良品、Apple", text: $brand)
              
              .focused($focused)
              .textFieldStyle(.roundedBorder)
          }          
          
          VStack(alignment: .leading, spacing: 5) {
            Text("サイズ")
              .font(.subheadline)
            TextField("例）Mサイズ、26.0cm", text: $size)
              .focused($focused)
              .textFieldStyle(.roundedBorder)
          }
          
          VStack(alignment: .leading, spacing: 5) {
            Text("重さ")
              .font(.subheadline)
            
            HStack {
              TextField("例）380", text: $weightInput)
                .focused($focused)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
              
              Picker("", selection: $weightUnit) {
                ForEach(Item.WeightUnit.allCases, id: \.self) { weightUnit in
                  Text(weightUnit.rawValue).tag(weightUnit as Item.WeightUnit)
                }
              }
              .pickerStyle(.segmented)
            }
            .frame(maxWidth: 240)

          }
        }
        .padding(.vertical)
      }
    }
}

#Preview {
    MyItemEditorDetailSection(
      focused: FocusState<Bool>().projectedValue,
      brand: .constant(""),
      size: .constant(""),
      weightInput: .constant(""),
      weightUnit: .constant(Item.WeightUnit.g)
    )
}
