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
  let defaultCategory: ItemCategory?
  
  @EnvironmentObject var snackbar: Snackbar
  
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
  
  init(item: Item? = nil, defaultCategory: ItemCategory? = nil) {
    self.item = item
    self.defaultCategory = defaultCategory
  }
  
  var body: some View {
    VStack(spacing: 0) {
      editorTab
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 0) {
          Group {
            if activeTab == EditorTabType.foundation {
              foundationFields
            }
            
            if activeTab == EditorTabType.detail {
              detailFields
            }
          }
          Spacer()
          saveButton
        }
      }
      .scrollBounceBehavior(.basedOnSize)
      .padding(.top, 15)
    }
    .padding()
    .onAppear {
      setDefaultValue()
    }
    .alert("Error", isPresented: $showValidationAlert) {
      Button("OK") {
        activeTab = .foundation
      }
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
          Button("Close") { focusField = nil }
            .tint(.foregroundSecondary)
        }
      }
    }
  }
  
  private func setDefaultValue() -> Void {
    if let _item = item {
      photoData = _item.photo
      name = _item.name
      maker = _item.maker ?? ""
      category = _item.category
      comment = _item.comment ?? ""
      purchaseDate = _item.purchaseDate
      if let priceValue = _item.price {
        price = String(priceValue)
      } else {
        price = ""
      }
      url = _item.url ?? ""
    } else {
      category = defaultCategory
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
      newItem.price = price.isEmpty ? nil : Float(price)
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
      
      snackbar.success(message: String(localized: "Successfully saved."))
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
      item.price = price.isEmpty ? nil : Float(price)
      item.url = url.isEmpty ? nil : url
      item.updatedAt = Date()
      
      snackbar.success(message: String(localized: "Successfully updated."))
      dismiss()
    }
  }
  
  private func validate() -> Bool {
    var result: Bool = true
    
    showValidationAlert = false
    validationMessages = []
    
    if photoData == nil {
      showValidationAlert = true
      validationMessages.append(String(localized: "Please select item image."))
      result = false
    }
    
    if name.isEmpty {
      showValidationAlert = true
      validationMessages.append(String(localized: "Please enter item name."))
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
      .padding(.top, 1)
      
      CustomTextField(label: String(localized: "Item name"), text: $name)
        .focused($focusField, equals: .name)
        .onTapGesture { // 余白をタップした場合にもフォーカスが当たるようにする
          focusField = .name
        }
      
      CustomTextField(label: String(localized: "Manufacturer / Brand"), text: $maker)
        .focused($focusField, equals: .maker)
        .onTapGesture {
          focusField = .maker
        }
      
      HStack(spacing: 15) {
        Picker("Category", selection: $category) {
          Text("Select a category").tag(nil as ItemCategory?)
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
          .frame(height: 200)
        
        if comment.isEmpty {
          Text("Description").foregroundStyle(.placeholder)
            .padding()
        }
      }
      .onTapGesture {
        focusField = .comment
      }
    }
  }
  
  private var detailFields: some View {
    VStack(alignment: .leading, spacing: 15) {
      CustomDatePicker(dateBinding: $purchaseDate, label: String(localized: "Date of purchase"))
      
      CustomTextField(label: String(localized: "Price"), text: $price)
        .focused($focusField, equals: .name)
        .keyboardType(.decimalPad)
        .onTapGesture {
          focusField = .price
        }
      
      CustomTextField(label: "URL", text: $url)
        .focused($focusField, equals: .name)
        .keyboardType(.URL)
        .onTapGesture {
          focusField = .url
        }
    }
  }
  
  @ViewBuilder
  private var saveButton: some View {
    Button(item == nil ? "Save" : "Save changes") {
      if let _item = item {
        update(item: _item)
      } else {
        create()
      }
    }
    .buttonStyle(PrimaryButtonStyle())
    .padding(.vertical, 10)
  }
  
  private var editorTab: some View {
    HStack(spacing: 0) {
      ForEach(EditorTabType.allCases, id: \.self) { tab in
        Button { activeTab = tab } label: {
          VStack {
            tab.text
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
    
    var text: Text {
      switch self {
      case .foundation: return Text("Basic")
      case .detail: return Text("Detailed")
      }
    }
  }
}

#Preview {
  ItemEditor()
    .modelContainer(PreviewModelContainer.container)
}
