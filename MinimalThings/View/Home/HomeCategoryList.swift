//
//  HomeCategoryList.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/17.
//

import SwiftUI
import SwiftData

let SCREEN_MAXX = UIScreen.main.bounds.width
let SCREEN_MIDX = UIScreen.main.bounds.width / 2
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
  @Query var categories: [ItemCategory]
  @State var activeIndex: Int = 1
  
  @State var dragX: CGFloat = 0
  
  var body: some View {
    ZStack {
      ForEach(0..<categories.count, id: \.self) { index in
        let category = categories[index]
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
        
        CategoryCard(category: category)
          .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
          .scaleEffect(scale)
          .rotationEffect(.degrees(angle))
          .offset(x: offsetX, y: 0)
          .zIndex(0)
          .animation(.easeOut, value: activeIndex)
      }
    }
    .gesture(
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
            activeIndex = min(activeIndex + moveIndex, categories.count - 1)
          }
          withAnimation { dragX = 0 }
        }
    )
  }
}

#Preview {
  HomeCategoryList()
    .modelContainer(PreviewModelContainer.container)
}
