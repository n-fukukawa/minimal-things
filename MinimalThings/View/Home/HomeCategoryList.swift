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
let LEADING_MAG: CGFloat = 1.1
let ACTIVE_MAG: CGFloat = 1.5
let INACTIVE_ANGLE: CGFloat = 5

struct HomeCategoryList: View {
  @Query var categories: [ItemCategory]
  @State var activeIndex: Int = 1
  
  @State var activeCardDragX: CGFloat = 0
  
  var body: some View {
    ZStack {
      ForEach(0..<categories.count, id: \.self) { index in
        let category = categories[index]
        let isActive = activeIndex == index
        // アクティブなカードに対して、左右のどちらにあるか（-1: 左, 1: 右, 0: アクティブ）
        let indexSign = (index - activeIndex).signum()
        let baseOffset: CGFloat = indexSign > 0 ? 200 : indexSign < 0 ? -100 : 0
        let dragProgress = {
          let progress = activeCardDragX / 120
          return progress < -1 ? -1 : progress > 1 ? 1 : progress
        }()
        let nextIndexWhenDragging = dragProgress < 0 ? activeIndex + 1 : activeIndex - 1
        
        let offsetX: CGFloat = {
          if isActive {
            return activeCardDragX
          } else if index == nextIndexWhenDragging {
            return (baseOffset + 40 * CGFloat(index - activeIndex)) * (1 - abs(dragProgress))
          } else {
            return baseOffset + 40 * (CGFloat(index - activeIndex) + dragProgress)
          }
        }()
        
        let scale: CGFloat = {
          if dragProgress < 0 {
            if isActive {
              return max(ACTIVE_MAG - CGFloat(abs(dragProgress * ((ACTIVE_MAG - LEADING_MAG) - 1))), LEADING_MAG)
            } else if index == nextIndexWhenDragging {
              return min(1 + CGFloat(abs(dragProgress * (ACTIVE_MAG - 1))), ACTIVE_MAG)
            } else if indexSign < 0 {
              return LEADING_MAG
            } else {
              return 1
            }
          } else {
            if isActive {
              return max(ACTIVE_MAG - CGFloat(abs(dragProgress * (ACTIVE_MAG - 1))), 1)
            } else if index == nextIndexWhenDragging {
              return min(LEADING_MAG + CGFloat(abs(dragProgress * (LEADING_MAG - 1))), ACTIVE_MAG)
            } else if indexSign < 0 {
              return LEADING_MAG
            } else {
              return 1
            }
          }
        }()
        
        let angle: CGFloat = {
          if isActive {
            return CGFloat(INACTIVE_ANGLE * dragProgress)
          } else if index == nextIndexWhenDragging {
            return INACTIVE_ANGLE * CGFloat(indexSign) + INACTIVE_ANGLE * CGFloat(dragProgress)
          } else {
            return INACTIVE_ANGLE * CGFloat(indexSign)
          }
        }()
        
        CategoryCard(category: category)
          .frame(width: 180, height: 270)
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
          // 感度が高いので移動量に0.5をかける
          let transition = value.translation.width * 0.5
          activeCardDragX = transition
        }
        .onEnded { value in
          if value.translation.width > 0 {
            activeIndex = max(activeIndex - 1, 0)
          }
          if value.translation.width < 0 {
            activeIndex = min(activeIndex + 1, categories.count - 1)
          }
          withAnimation { activeCardDragX = 0 }
        }
    )
  }
}

#Preview {
  HomeCategoryList()
    .modelContainer(PreviewModelContainer.container)
}
