//
//  ItemEditor.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/23.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ItemEditor: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.modelContext) var modelContext
  @Query(sort: \ItemCategory.sortOrder) var categories: [ItemCategory]
  let item: Item?
  
  @State private var activeTab = EditorTabType.foundation
  
  @State private var photoData: Data? = nil
  @State private var name: String = ""
  @State private var maker: String = ""
  @State private var category: ItemCategory?
  @State private var comment: String = ""
  @State private var purchaseDate: Date?
  @State private var price: String = ""
  @State private var url: String = ""
  
  enum Field {
    case name
    case maker
    case comment
    case price
    case url
  }
  
  @FocusState private var focusField: Field?
  
  @State private var showValidationAlert: Bool = false
  @State private var validationMessages: [String] = []
  
  init(item: Item? = nil) {
    self.item = item
  }
  
  var body: some View {
    VStack(spacing: 0) {
      editorTab
      
      Group {
        if activeTab == EditorTabType.foundation {
          foundationFields
        }
        
        if activeTab == EditorTabType.detail {
          detailFields
        }
      }
      .padding(.top, 20)
      
      Spacer()
      
      saveButton
    }
    .padding()
    .onAppear {
      onAppear()
    }
    .alert("エラー", isPresented: $showValidationAlert) {
    } message: {
      Text(validationMessages.joined(separator: "\n"))
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button { dismiss() } label: {
          Image(systemName: "xmark")
            .tint(.foregroundSecondary)
        }
      }
      ToolbarItem(placement: .keyboard) {
        HStack {
          Spacer()
          Button("閉じる") { focusField = nil }
            .tint(.foregroundSecondary)
        }
      }
    }
  }
  
  private func onAppear() -> Void {
    if let _item = item {
      photoData = _item.photo
      name = _item.name
      maker = _item.maker ?? ""
      category = _item.category
      comment = _item.comment ?? ""
      purchaseDate = _item.purchaseDate
      price = _item.price == nil ? "" : String(price)
      url = _item.url ?? ""
    }
  }
  
  private func create() -> Void {
    if validate() {
      let newItem = Item(name: name)
      newItem.photo = photoData
      newItem.maker = maker.isEmpty ? nil : maker
      newItem.comment = comment.isEmpty ? nil : comment
      newItem.category = category
      newItem.purchaseDate = purchaseDate
      newItem.price = price.isEmpty ? nil : Int(price)
      newItem.url = url.isEmpty ? nil : url
      newItem.createdAt = Date()
      newItem.updatedAt = newItem.createdAt
      
      let predicate = Item.fetchByCategory(category: category)
      let fetchDescriptor = FetchDescriptor(predicate: predicate)
      let maxSortOrder = try? modelContext.fetch(fetchDescriptor).map{$0.sortOrder}.max()
      if let maxSortOrder = maxSortOrder {
        newItem.sortOrder = maxSortOrder + 1
      }
      
      modelContext.insert(newItem)
      
      dismiss()
    }
  }
  
  private func update(item: Item) -> Void {
    if validate() {
      item.photo = photoData
      item.name = name
      item.maker = maker.isEmpty ? nil : maker
      item.comment = comment.isEmpty ? nil : comment
      item.category = category
      item.purchaseDate = purchaseDate
      item.price = price.isEmpty ? nil : Int(price)
      item.url = url.isEmpty ? nil : url
      item.updatedAt = Date()
      
      dismiss()
    }
  }
  
  private func validate() -> Bool {
    var result: Bool = true
    
    showValidationAlert = false
    validationMessages = []
    
    if photoData == nil {
      showValidationAlert = true
      validationMessages.append("画像を選択してください")
      result = false
    }
    
    if name.isEmpty {
      showValidationAlert = true
      validationMessages.append("名前を入力してください")
      result = false
    }
    
    return result
  }
  
  private var foundationFields: some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Spacer()
        ItemEditorPhotoField(photoData: $photoData)
        Spacer()
      }
      
      CustomTextField(label: "名前", text: $name)
        .focused($focusField, equals: .name)
      
      CustomTextField(label: "メーカー / ブランド", text: $maker)
        .focused($focusField, equals: .maker)
      
      HStack(spacing: 15) {
        Picker("カテゴリ", selection: $category) {
          Text("カテゴリを選択").tag(nil as ItemCategory?)
          ForEach(categories) { category in
            Text(category.name).tag(category as ItemCategory)
          }
        }
        .padding(6)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.containerDivider, lineWidth: 1)
        )
        .tint(.foregroundSecondary)
        
        NavigationLink {
          CategorySetting()
        } label: {
          Image(systemName: "gearshape.fill")
            .foregroundStyle(.foregroundTertiary)
        }
      }
      
      ZStack(alignment: .topLeading) {
        TextEditor(text: $comment)
          .focused($focusField, equals: .comment)
          .multilineTextAlignment(.leading)
          .lineSpacing(4)
          .padding(8)
          .border(Color(UIColor.systemGray5), width: 1)
        
        if comment.isEmpty {
          Text("コメント").foregroundStyle(.placeholder)
            .padding()
        }
      }
    }
  }
  
  private var detailFields: some View {
    VStack(alignment: .leading, spacing: 15) {
      CustomDatePicker(dateBinding: $purchaseDate, label: "購入日")
      
      CustomTextField(label: "価格", text: $price)
        .focused($focusField, equals: .name)
        .keyboardType(.numberPad)
      
      CustomTextField(label: "URL", text: $url)
        .focused($focusField, equals: .name)
        .keyboardType(.URL)
    }
  }
  
  @ViewBuilder
  private var saveButton: some View {
    if focusField == nil {
      Button(item == nil ? "作成" : "上書き保存") {
        if let _item = item {
          update(item: _item)
        } else {
          create()
        }
      }
      .buttonStyle(PrimaryButtonStyle())
      .padding(.vertical, 10)
    }
  }
  
  private var editorTab: some View {
    HStack(spacing: 0) {
      ForEach(EditorTabType.allCases, id: \.self) { tab in
        Button { activeTab = tab } label: {
          VStack {
            Text(tab.name)
              .foregroundStyle(tab == activeTab ? .accentColor : Color.foregroundTertiary)
              .padding(4)
            Rectangle()
              .fill(tab == activeTab ? .accentColor : Color.containerDivider)
              .frame(height: 2)
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
  }
  
  private enum EditorTabType: String, CaseIterable {
    case foundation
    case detail
    
    var name: String {
      switch self {
      case .foundation: return "基本"
      case .detail: return "詳細"
      }
    }
  }
}

#Preview {
  ItemEditor()
    .modelContainer(PreviewModelContainer.container)
}
