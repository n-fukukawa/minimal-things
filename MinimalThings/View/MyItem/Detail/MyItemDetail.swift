//
//  MyItemDetail.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/06.
//

import SwiftUI

struct MyItemDetail: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  var item: Item
  
  @State private var isEditorPresented: Bool = false
  @State private var isDeleteConfirmationPresented: Bool = false
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading) {
          MyItemDetailImage(item: item, size: geometry.size.width)
          VStack(alignment: .leading) {
            MyItemDetailHeader(item: item).padding(.bottom, 20)
            MyItemDetailTabView(item: item)
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 15)
        }
        .foregroundStyle(Color.foreground)
        .sheet(isPresented: $isEditorPresented ){
          NavigationStack {
            MyItemEditor(item: item, dismissAction: { isEditorPresented = false })
              .navigationTitle("編集")
              .navigationBarTitleDisplayMode(.inline)
              .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                  Button {
                    isEditorPresented = false
                  } label : {
                    Label("閉じる", systemImage: "xmark")
                  }
                }
              }
          }
        }
      }
    }
    .toolbar {
      ToolbarItemGroup(placement: .secondaryAction) {
        Button("編集") {
          isEditorPresented.toggle()
        }
        Button("削除", role: .destructive) {
          isDeleteConfirmationPresented.toggle()
        }
        .confirmationDialog("", isPresented: $isDeleteConfirmationPresented) {
          Button("削除", role: .destructive) {
            modelContext.delete(item)
            dismiss()
          }
          Button("キャンセル", role: .cancel) {}
        }
      }
    }
  }
}

#Preview {
  let item = Item(name: "急速充電ができるモバイルバッテリー", status: .owned)
  item.images = [Data()]
  item.category = nil
  item.memo = """
  【商品の特長】
  ＵＳＢ－C/A 2個口のモバイルバッテリー付き急速充電器で、プラグ式で持ち運びに便利です。
  USB-C単一ポートで出力の場合PD20W対応、USBA単一ポートで出力の場合QC18W対応
  2ポート同時使用時合計15Wの出力が可能2台当時充電可能です。
  """
  item.brand = "無印良品"
  item.size = "奥行：3.32cm　幅：7.83cm　高さ：8.70cm　重さ：0.26kg"
  item.gram = 285
  item.weightUnit = Item.WeightUnit.g
  item.color = Item.ItemColor.white
  item.purchasedAt = Date()
  item.shop = "無印良品オンラインショップ"
  item.url = "https://www.muji.com/jp/ja/store/cmdty/section/T20213"
  return MyItemDetail(item: item)
}
