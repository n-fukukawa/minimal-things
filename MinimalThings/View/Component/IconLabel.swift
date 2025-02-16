//
//  IconLabel.swift
//  MinimalThings
//
//  Created by Naruki Fukukawa on 2025/02/16.
//

import SwiftUI

struct IconLabel: View {
  var label: String
  var icon: String
  var isURL: Bool = false
  
  var body: some View {
    Label(
      title: {
        if isURL, let url = URL(string: label) {
          HStack(alignment: .bottom) {
            Link(label, destination: url)
              .lineLimit(1)
              .font(.caption)
            ShareLink("", item: url)
              .font(.subheadline)
          }
          .foregroundStyle(.foregroundSecondary)
        } else {
          Text(label)
            .lineLimit(1)
            .font(.caption)
            .foregroundStyle(.foregroundSecondary)
        }
      },
      icon: {
        Image(systemName: icon)
          .font(.subheadline)
          .foregroundStyle(.foregroundTertiary)
      }
    )
  }
}

#Preview {
  IconLabel(label: "2025/02/15", icon: "calendar")
}
