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
    
    init(date: Date, isSelected: Bool, dailyPercentage: ExerciseCalendar? = nil) {
        self.date = date
        self.isSelected = isSelected
        self.dailyPercentage = dailyPercentage
    }
    
    var body: some View {
        VStack {
            if let percentage = dailyPercentage {
                NavigationLink(destination: DiaryDetailView()) {
                    DayContent(date: date, isSelected: isSelected, percentage: percentage.dailyPercentage)
                }
            } else {
                NavigationLink(destination: WriteDiary(writeDiaryViewModel: WriteDiaryViewModel(diaryService: DiaryService(diaryRepository: DiaryRepository()), memberService: MemberService(memberRepository: MemberRepository())), date: date.toString())) {
                    DayContent(date: date, isSelected: isSelected, percentage: nil)
                }
            }
        }
    }
}

struct DayContent: View {
    var date: Date
    var isSelected: Bool
    var percentage: Int?
    
    var body: some View {
        VStack {
            Text("\(Calendar.current.component(.day, from: date))")
                .padding(8)
                .clipShape(Circle())
                .font(.system(size: 18))
                .foregroundStyle(Color(.label))
            
            if let percentage = percentage {
                Text("\(percentage)%")
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .font(.system(size: 15))
                    .padding(.top, -8)
            } else {
                Text("")
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .font(.system(size: 15))
                    .padding(.top, -8)
            }
        }
    }
}
