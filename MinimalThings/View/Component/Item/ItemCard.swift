//
//  ItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData

struct ItemCard: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  var item: Item
  var detail: Bool
  
  init(item: Item, detail: Bool = false) {
    self.item = item
    self.detail = detail
  }
  
  @State private var showEditor: Bool = false
  @State private var showDeleteDialog: Bool = false
  
  let paddingSize = SCREEN_MAXX * 0.07
  
  var body: some View {
    if detail {
      ZStack {
        Rectangle()
          .fill(Color.containerBackground)
          .ignoresSafeArea()
        content
          .navigationBarBackButtonHidden()
          .sheet(isPresented: $showEditor) {
            NavigationStack {
              ItemEditor(item: item)
            }
          }
      }
    } else {
      ZStack {
        RoundedRectangle(cornerRadius: detail ? 10 : 5)
          .fill(.containerBackground)
          .shadow(color: .shadow, radius: 2, x: 0, y: 1)
        content
      }
      .padding(6)
    }
  }
  
  private var content: some View {
    return ZStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 0) {
          photo
          Divider()
          VStack(alignment: .leading, spacing: 0) {
            itemTitle
            if detail {
              makerText.padding(.top, 6)
              commentText.padding(.top, paddingSize)
              itemDetails.padding(.top, paddingSize)
            }
          }
          .padding(.top, detail ? 30 : 12)
          .padding(.bottom, detail ? 15 : 15)
          .padding(.horizontal, detail ? SCREEN_MAXX * 0.07 : 10)
        }
      }
      if detail { hoverActionButtons }
    }
    .scrollBounceBehavior(.basedOnSize, axes: .vertical)
  }
  
  @ViewBuilder
  private var photo: some View {
    if let data = item.photo, let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .scaledToFit()
        .aspectRatio(1, contentMode: .fit)
        .clipShape(UnevenRoundedRectangle(
          topLeadingRadius: detail ? 0 : 5, topTrailingRadius: detail ? 0 : 5)
        )
        .frame(
          maxWidth: detail ? SCREEN_MAXX : .infinity,
          maxHeight: detail ? SCREEN_MAXX : .infinity
        )
    }
  }
  
  private var itemTitle: some View {
    Text(item.name)
      .lineLimit(2, reservesSpace: !detail)
      .multilineTextAlignment(.leading)
      .font(detail ? .title3 : .caption)
      .fontWeight(.semibold)
      .foregroundStyle(.foregroundSecondary)
  }
  
  @ViewBuilder
  private var makerText: some View {
    if let maker = item.maker {
      Text(maker)
        .lineLimit(1)
        .font(.subheadline)
        .foregroundStyle(.foregroundTertiary)
    }
  }
  
  @ViewBuilder
  private var commentText: some View {
    if let comment = item.comment {
      VStack(spacing: 0) {
        Text(comment)
          .multilineTextAlignment(.leading)
          .font(.subheadline)
          .lineSpacing(8)
          .foregroundStyle(.foregroundSecondary)
          .padding(.trailing)
        
        Divider().padding(.top, paddingSize)
      }
    }
  }
  
  private var itemDetails: some View {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    return VStack(alignment: .leading, spacing: 10) {
      if let purchaseDate = item.purchaseDate {
        IconLabel(
          label: dateFormatter.string(from: purchaseDate),
          icon: "calendar"
        )
      }
      
      if let price = item.price {
        IconLabel(
          label: numberFormatter.string(from: price as NSNumber) ?? String(price),
          icon: "wallet.pass"
        )
      }
      
      if let url = item.url {
        IconLabel(
          label: url,
          icon: "link",
          isURL: true
        )
      }
    }
  }
  
  private var hoverActionButtons: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark")
      }
      .buttonStyle(HoverActionButtonStyle())
      
      Spacer()
      
      Menu {
        editButton
        deleteButton
      } label: {
        Image(systemName: "ellipsis")
      }
      .buttonStyle(HoverActionButtonStyle())
      .confirmationDialog("", isPresented: $showDeleteDialog) {
        Button("Delete", role: .destructive) {
          modelContext.delete(item)
          dismiss()
        }
        Button("Cancel", role: .cancel) {}
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding(.horizontal, 15)
    .padding(.top, 10)
  }
  
  private var editButton: some View {
    Button {
      showEditor.toggle()
    } label: {
      Label("Edit", systemImage: "pencil")
        .font(.subheadline)
    }  }
  
  private var deleteButton: some View {
    Button(role: .destructive) {
      showDeleteDialog.toggle()
    } label: {
      Label("Delete", systemImage: "trash")
        .font(.subheadline)
    }
  }
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCard(item: items[0])
    .frame(width: 160, height: 160 * 1.5)
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCard(item: items[1], detail: true)
}



