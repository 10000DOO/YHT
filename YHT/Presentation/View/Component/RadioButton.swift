//
//  RadioButton.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import Foundation
import SwiftUI

struct RadioButton: View {
    @Binding var selectedOption: String
    let text: String
    
    var body: some View {
        Button(action: {
            selectedOption = text
        }) {
            HStack {
                Image(systemName: selectedOption == text ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                Text(text)
                    .font(.system(size: 20))
            }
        }
        .foregroundColor(.primary)
        .padding(.vertical, 4)
    }
}

