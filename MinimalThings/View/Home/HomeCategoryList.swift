//
//  HomeCategoryList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData


let LEADING_MAG: CGFloat = 1.0
let TRAILING_MAG: CGFloat = 1.0
let ACTIVE_MAG: CGFloat = 1.5
let LEADING_CARD_INTERVAL: CGFloat = 30
let TRAILING_CARD_INTERVAL: CGFloat = 10
let INACTIVE_ANGLE: CGFloat = 5

let CARD_WIDTH = SCREEN_MAXX / ACTIVE_MAG * 0.7
let CARD_HEIGHT = CARD_WIDTH * 1.5

let CRITICAL_DRAGX = CARD_WIDTH * 4 / 3

// show interstitial ads when screen displayed 15 times
let INTERSTITIAL_FREQUENCY = 15

struct HomeCategoryList: View {
  @Environment(\.modelContext) var modelContext
  @Query var nonCategoryItems: [Item]
  
  let categories: [ItemCategory]
  @Binding private var activeCategoryIndex: Int
  @State var activeIndex: Int = 0
  @State var dragX: CGFloat = 0
  @State private var displayedCount: Int = 0
  
  let interstitialViewModel = InterstitialViewModel()
  
  init(categories: [ItemCategory], activeCategoryIndex: Binding<Int>) {
    self.categories = categories
    let predicate = Item.fetchByCategory(category: nil)
    _nonCategoryItems = Query(filter: predicate)
    _activeCategoryIndex = activeCategoryIndex
  }
  
  var body: some View {
    let dragProgress = {
      let progress = dragX / CRITICAL_DRAGX
      return progress < -1 ? -1 : progress > 1 ? 1 : progress
    }()
    let nextIndex = dragProgress < 0 ? activeIndex + 1 : activeIndex - 1
    
    func getOffsetX(index: Int, isActive: Bool) -> CGFloat {
      // アクティブなカードに対して、左右のどちらにあるか（-1: 左, 1: 右, 0: アクティブ）
      let indexSign = (index - activeIndex).signum()
      
      if isActive {
        return dragX * 0.5 // 感度が高いので移動量に0.5をかける
      } else {
        let baseOffset: CGFloat = indexSign > 0
        ? CARD_WIDTH * ACTIVE_MAG - TRAILING_CARD_INTERVAL * 2
        : -(CARD_WIDTH / 3)
        let cardInterval = indexSign > 0 ? TRAILING_CARD_INTERVAL : LEADING_CARD_INTERVAL
        if index == nextIndex {
          return (baseOffset + cardInterval * CGFloat(index - activeIndex)) * (1 - abs(dragProgress))
        } else {
          return baseOffset + cardInterval * (CGFloat(index - activeIndex) + dragProgress)
        }
      }
    }
    
    func getScale(index: Int, isActive: Bool) -> CGFloat {
      // アクティブなカードに対して、左右のどちらにあるか（-1: 左, 1: 右, 0: アクティブ）
      let indexSign = (index - activeIndex).signum()
      
      if dragProgress < 0 {
        if isActive {
          return ACTIVE_MAG - (ACTIVE_MAG - LEADING_MAG) * abs(dragProgress)
        } else if index == nextIndex {
          return ACTIVE_MAG - (ACTIVE_MAG - TRAILING_MAG) * (1 - abs(dragProgress))
        } else {
          return indexSign < 0 ? LEADING_MAG : TRAILING_MAG
        }
      } else {
        if isActive {
          return ACTIVE_MAG - (ACTIVE_MAG - TRAILING_MAG) * abs(dragProgress)
        } else if index == nextIndex {
          return LEADING_MAG + (ACTIVE_MAG - LEADING_MAG) * abs(dragProgress)
        } else {
          return indexSign < 0 ? LEADING_MAG : TRAILING_MAG
        }
      }
    }
    
    func getAngle(index: Int, isActive: Bool) -> CGFloat {
      // アクティブなカードに対して、左右のどちらにあるか（-1: 左, 1: 右, 0: アクティブ）
      let indexSign = (index - activeIndex).signum()
      
      if isActive {
        return CGFloat(INACTIVE_ANGLE * dragProgress)
      } else if index == nextIndex {
        return INACTIVE_ANGLE * CGFloat(indexSign) + INACTIVE_ANGLE * CGFloat(dragProgress)
      } else {
        return INACTIVE_ANGLE * CGFloat(indexSign)
      }
    }
    
    func categoryCard(category: ItemCategory?, index: Int, isActive: Bool) -> some View {
      let items = category?.items ?? nonCategoryItems
      return CategoryCard(category: category, items: items)
        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
        .scaleEffect(getScale(index: index, isActive: isActive))
        .rotationEffect(.degrees(getAngle(index: index, isActive: isActive)))
        .offset(x: getOffsetX(index: index, isActive: isActive), y: 0)
        .zIndex(0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.timingCurve(0.27, 0, 0.23, 1, duration: 0.7), value: activeIndex)
    }
    
    return ZStack {
      Rectangle()
        .fill(.backgroundPrimary)
        .onAppear {
          if displayedCount % INTERSTITIAL_FREQUENCY == 1 {
            interstitialViewModel.showAd()
            Task {
              await interstitialViewModel.loadAd()
            }
          }
          displayedCount += 1
        }
      
      ForEach(0..<categories.count, id: \.self) { index in
        let category = categories[index]
        let isActive = activeIndex == index
        let items = category.items
        
        NavigationLink {
          CategoryCard(category: category, items: items, detail: true)
        } label: {
          categoryCard(category: category, index: index, isActive: isActive)
        }
        // ドラッグ時にカードの透明度が変わらないようにする
        .buttonStyle(FlatLinkStyle())
      }
      
      if !_nonCategoryItems.wrappedValue.isEmpty {
        let index = categories.count
        let isActive = activeIndex == index
        
        NavigationLink {
          CategoryCard(category: nil, items: nonCategoryItems, detail: true)
        } label: {
          categoryCard(category: nil, index: index, isActive: isActive)
        }
        // ドラッグ時にカードの透明度が変わらないようにする
        .buttonStyle(FlatLinkStyle())
      }
    }
    .highPriorityGesture(
      DragGesture()
        .onChanged { value in
          let transition = value.translation.width
          dragX = transition
        }
        .onEnded { value in
          let moveIndex = 1
          if value.translation.width > 0 {
            activeIndex = max(activeIndex - moveIndex, 0)
          }
          if value.translation.width < 0 {
            let maxIndex = nonCategoryItems.isEmpty ? categories.count - 1 : categories.count
            activeIndex = min(activeIndex + moveIndex, maxIndex)
          }
          dragX = 0
          activeCategoryIndex = activeIndex
        }
    )
    .onAppear {
      Task {
        await interstitialViewModel.loadAd()
      }
    }
  }
}

#Preview {
  @Previewable @Query var categories: [ItemCategory]
  return HomeCategoryList(categories: categories, activeCategoryIndex: .constant(0))
    .modelContainer(PreviewModelContainer.container)
}
