//
//  ItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData

struct ItemCard: View {
  @Environment(\.dismiss) var dismiss
  let item: Item
  let detail: Bool
  
  @State private var isFront: Bool = true
  
  init(item: Item, detail: Bool = false) {
    self.item = item
    self.detail = detail
  }
  
  var body: some View {
    if detail {
      VStack {
        content
          .padding()
          .onTapGesture {
            withAnimation(.timingCurve(0.47, 0, 0.23, 1, duration: 0.7)) {
              isFront.toggle()
            }
          }
      }
      .aspectRatio(2/3, contentMode: .fit)
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button { dismiss() } label: {
            Image(systemName: "chevron.left")
              .font(.title3)
              .tint(.foregroundSecondary)
          }
          .padding(.leading, 8)
        }
      }
    } else {
      ItemCardFront(item: item, detail: detail)
    }
  }
  
  var content: some View {
    ZStack {
      ItemCardFront(item: item, detail: detail)
        .rotation3DEffect(.init(degrees: isFront ? 0 : 180), axis: (x: 0, y: -1, z: 0))
        .modifier(FlipOpacityTransition(progress: isFront ? 1 : 0))
      ItemCardBack(item: item)
        .rotation3DEffect(.init(degrees: isFront ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .modifier(FlipOpacityTransition(progress: isFront ? 0 : 1))
    }
  }
}

private struct FlipOpacityTransition: ViewModifier, Animatable {
  var progress: CGFloat = 0
  var animatableData: CGFloat {
    get { progress }
    set { progress = newValue }
  }
  
  func body(content: Content) -> some View {
    //例えば表面のprogressが1 → 0、裏面のprogressが0 → 1で変更させるとする
    //進捗率が50%以上（つまりカードが90度回転したとき）で、表面のopacityを0になり、裏面のopacityを1になる
    content
      .opacity(progress.rounded())
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
    .frame(width: 300, height: 450)
}

#Preview {
  let container = PreviewModelContainer.container
  let predicate = Item.search()
  let fetchDescriptor = FetchDescriptor(
    predicate: predicate,
    sortBy: [.init(\Item.name)]
  )
  let items = try! container.mainContext.fetch(fetchDescriptor)
  
  return ItemCard(item: items[0], detail: true)
    .frame(width: 300, height: 450)
}

