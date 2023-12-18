//
//  CalendarGridView.swift
//  YHT
//
//  Created by 이건준 on 12/18/23.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var currentDate: Date
    private let calendar = Calendar.current
    let calendars: [ExerciseCalendar]?
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(getDateRange(for: currentDate), id: \.self) { date in
                if date == Date(timeIntervalSince1970: 0) {
                    Spacer()
                } else {
                    if let calendarArr = calendars {
                        let dailyPercentage = calendarArr.first { $0.exerciseDate == date.toString() }
                        DayView(date: date, isSelected: date == self.currentDate, dailyPercentage: dailyPercentage)
                            .onTapGesture {
                                self.currentDate = date
                            }
                    } else {
                        DayView(date: date, isSelected: date == self.currentDate)
                            .onTapGesture {
                                self.currentDate = date
                            }
                    }
                }
            }
        }
    }
    
    private func getDateRange(for date: Date) -> [Date] {
        var startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!
        
        let startWeekday = calendar.component(.weekday, from: startDate) - 1
        var dates: [Date] = Array(repeating: Date(timeIntervalSince1970: 0), count: startWeekday)
        
        while startDate <= endDate {
            dates.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        
        return dates
    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

