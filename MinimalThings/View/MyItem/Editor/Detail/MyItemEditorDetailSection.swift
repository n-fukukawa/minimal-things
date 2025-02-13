//
//  MyItemEditorDetailSection.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/09.
//

import SwiftUI

struct MyItemEditorDetailSection: View {
  @FocusState.Binding var focused: Bool
  @Binding var maker: String
  @Binding var size: String
  @Binding var weightInput: String
  @Binding var weightUnit: Item.WeightUnit
  @Binding var color: Item.ItemColor?
  @Binding var priceInput: String
  @Binding var purchasedAt: Date?
  @Binding var shop: String
  @Binding var url: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      VStack(alignment: .leading, spacing: 4) {
        Text("メーカー")
          .font(.subheadline)
        TextField("", text: $maker)
        
          .focused($focused)
          .textFieldStyle(.roundedBorder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("サイズ")
          .font(.subheadline)
        TextField("", text: $size)
          .focused($focused)
          .textFieldStyle(.roundedBorder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("重さ")
          .font(.subheadline)
        
        HStack {
          TextField("", text: $weightInput)
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
      
      VStack(alignment: .leading, spacing: 4) {
        Text("カラー")
          .font(.subheadline)
        Picker("", selection: $color) {
          Text("選択してください").tag(nil as Item.ItemColor?)
          ForEach(Item.ItemColor.allCases, id: \.self) { color in
            Label(
              title: { Text("\(color.text)")},
              icon: { colorImage(color: color.color)}
            )
            .tag(color as Item.ItemColor?)
          }
        }
        .pickerStyle(.menu)
      }
      
      VStack(alignment: .leading, spacing: 4) {
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
      
      VStack(alignment: .leading, spacing: 4) {
        Text("購入場所")
          .font(.subheadline)
        TextField("", text: $shop)
          .focused($focused)
          .textFieldStyle(.roundedBorder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("URL")
          .font(.subheadline)
        TextField("", text: $url)
          .focused($focused)
          .keyboardType(.URL)
          .textFieldStyle(.roundedBorder)
      }
    }
    .padding(.bottom)
    .onAppear {
      UISegmentedControl.appearance().selectedSegmentTintColor = .text
      UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
      UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.text)], for: .normal)
    }
  }
  
  private func colorImage(color: Color) -> Image {
    Image(size: CGSize(width: 26, height: 20)) { ctx in
      ctx.fill(
        Path(
          roundedRect: CGRect(origin: .zero, size: CGSize(width: 18, height: 18)),
          cornerRadius: 0
        ),
        with: .color(color)
      )
      ctx.stroke(
        Path(
          roundedRect: CGRect(origin: .zero, size: CGSize(width: 18, height: 18)),
          cornerRadius: 0
        ),
        with: .color(Color(UIColor.systemGray3)),
        lineWidth: 1
      )
    }
  }
}

#Preview {
  MyItemEditorDetailSection(
    focused: FocusState<Bool>().projectedValue,
    maker: .constant(""),
    size: .constant(""),
    weightInput: .constant(""),
    weightUnit: .constant(Item.WeightUnit.g),
    color: .constant(nil),
    priceInput: .constant(""),
    purchasedAt: .constant(nil),
    shop: .constant(""),
    url: .constant("")
  )
}
