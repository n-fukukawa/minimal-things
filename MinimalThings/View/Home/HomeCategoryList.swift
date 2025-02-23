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

struct HomeCategoryList: View {
  @Namespace var namespace
  @Query(sort: \ItemCategory.sortOrder) var categories: [ItemCategory]
  @State var activeIndex: Int = 6
  
  @State var dragX: CGFloat = 0
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.backgroundPrimary)
      
      ForEach(0..<categories.count + 1, id: \.self) { index in
        let category = index == categories.count ? nil : categories[index]
        let isActive = activeIndex == index
        // アクティブなカードに対して、左右のどちらにあるか（-1: 左, 1: 右, 0: アクティブ）
        let indexSign = (index - activeIndex).signum()
        let dragProgress = {
          let progress = dragX / CRITICAL_DRAGX
          return progress < -1 ? -1 : progress > 1 ? 1 : progress
        }()
        let nextIndex = dragProgress < 0 ? activeIndex + 1 : activeIndex - 1
        
        let offsetX: CGFloat = {
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
        }()
        
        let scale: CGFloat = {
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
        }()
        
        let angle: CGFloat = {
          if isActive {
            return CGFloat(INACTIVE_ANGLE * dragProgress)
          } else if index == nextIndex {
            return INACTIVE_ANGLE * CGFloat(indexSign) + INACTIVE_ANGLE * CGFloat(dragProgress)
          } else {
            return INACTIVE_ANGLE * CGFloat(indexSign)
          }
        }()
        
        NavigationLink {
          CategoryCard(category: category, detail: true)
            .navigationTransition(.zoom(sourceID: category?.name ?? "no", in: namespace))
        } label: {
          CategoryCard(category: category)
            .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
            .scaleEffect(scale)
            .rotationEffect(.degrees(angle))
            .offset(x: offsetX, y: 0)
            .zIndex(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.timingCurve(0.27, 0, 0.23, 1, duration: 0.7), value: activeIndex)
            .matchedTransitionSource(id: category?.name ?? "no", in: namespace)
        }
        // ドラッグ時にカードの透明度が変わらないようにする
        .buttonStyle(FlatLinkStyle())
      }
    }
    //      .frame(width: .infinity, height: .infinity)
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
            activeIndex = min(activeIndex + moveIndex, categories.count)
          }
          dragX = 0
        }
    )
  }
}

#Preview {
  HomeCategoryList()
    .modelContainer(PreviewModelContainer.container)
}
