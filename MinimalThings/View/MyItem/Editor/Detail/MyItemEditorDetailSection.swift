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
  @Binding var color: Item.ItemColor?
  @Binding var priceInput: String
  @Binding var purchasedAt: Date?
  @Binding var shop: String
  
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
        
        VStack(alignment: .leading, spacing: 5) {
          Text("カラー")
            .font(.subheadline)
          Picker("", selection: $color) {
            Text("選択してください").tag(nil as Item.ItemColor?)
            ForEach(Item.ItemColor.allCases, id: \.self) { color in
              Label(
                title: { Text("\(color.text)")},
                icon: { colorImage(color: color.color) })
              .tag(color as Item.ItemColor?)
              
            }
          }
          .pickerStyle(.menu)
        }
        
        VStack(alignment: .leading, spacing: 5) {
          Text("価格")
            .font(.subheadline)
          HStack(spacing: 5) {
            TextField("", text: $priceInput)
              .focused($focused)
              .keyboardType(.numberPad)
              .textFieldStyle(.roundedBorder)
              .frame(maxWidth: 160)
            Text("円")
          }
        }
        
        MyItemEditorPurchaseDateField(purchasedAt: $purchasedAt)
        
        VStack(alignment: .leading, spacing: 5) {
          Text("購入場所")
            .font(.subheadline)
          TextField("", text: $shop)
            .focused($focused)
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
        }
      }
      .padding(.vertical)
    }
  }
  
  private func colorImage(color: Color) -> Image {
    Image(size: CGSize(width: 26, height: 20)) { ctx in
      ctx.fill(
        Path(
          roundedRect: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)),
          cornerRadius: 3
        ),
        with: .color(color)
      )
    }
  }
}

#Preview {
  MyItemEditorDetailSection(
    focused: FocusState<Bool>().projectedValue,
    brand: .constant(""),
    size: .constant(""),
    weightInput: .constant(""),
    weightUnit: .constant(Item.WeightUnit.g),
    color: .constant(nil),
    priceInput: .constant(""),
    purchasedAt: .constant(nil),
    shop: .constant("")
  )
}
