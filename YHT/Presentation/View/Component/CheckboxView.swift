//
//  CheckboxView.swift
//  YHT
//
//  Created by 이건준 on 12/22/23.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(isChecked ? Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)) : .secondary)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1)
            )
            .onTapGesture { isChecked.toggle() }
    }
}
