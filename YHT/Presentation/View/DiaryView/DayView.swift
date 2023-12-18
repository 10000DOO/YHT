//
//  DayView.swift
//  YHT
//
//  Created by 이건준 on 12/18/23.
//

import SwiftUI

struct DayView: View {
    var date: Date
    var isSelected: Bool
    var dailyPercentage: ExerciseCalendar?
    
    var body: some View {
        VStack {
            Text("\(Calendar.current.component(.day, from: date))")
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .background(isSelected ? Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)) : Color.clear)
                .clipShape(Circle())
                .foregroundColor(isSelected ? .white : .primary)
                .font(.system(size: 18))
            
            if let percentage = dailyPercentage {
                Text("\(percentage.dailyPercentage)%")
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .font(.system(size: 15))
            } else {
                Text("")
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .font(.system(size: 15))
            }
        }
    }
}
