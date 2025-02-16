//
//  ItemCard.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData

struct ItemCard: View {
  let item: Item
  @State private var isFront: Bool = true
  
  
  var body: some View {
    ZStack {
        ItemCardFront(item: item)
          .rotation3DEffect(.init(degrees: isFront ? 0 : 180), axis: (x: 0, y: -1, z: 0))
          .modifier(FlipOpacityTransition(progress: isFront ? 1 : 0))
        ItemCardBack(item: item)
          .rotation3DEffect(.init(degrees: isFront ? 180 : 0), axis: (x: 0, y: 1, z: 0))
          .modifier(FlipOpacityTransition(progress: isFront ? 0 : 1))
    }
    .onTapGesture {
      withAnimation(
        .timingCurve(0.47, 0, 0.23, 1, duration: 0.7)
      ) {
        isFront.toggle()
      }
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
