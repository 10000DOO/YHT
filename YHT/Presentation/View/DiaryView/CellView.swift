//
//  CellView.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import SwiftUI

struct CellView: View {
  var day: Int
  var clicked: Bool = false
  
  init(day: Int, clicked: Bool) {
    self.day = day
    self.clicked = clicked
  }
  
  var body: some View {
    VStack {
      RoundedRectangle(cornerRadius: 5)
        .opacity(0)
        .overlay(
            Text("\(day)")
                .foregroundColor(Color(.label))
                .fontWeight(.bold)
        )
        .foregroundColor(.blue)
      
      if clicked {
          Image(systemName: "circle.fill")
          .foregroundColor(.red)
          .scaleEffect(0.5)
      } else {
          Image(systemName: "circle.fill")
          .foregroundColor(.clear)
          .scaleEffect(0.5)
      }
    }
  }
}
