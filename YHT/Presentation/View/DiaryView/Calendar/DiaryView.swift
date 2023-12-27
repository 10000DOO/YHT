//
//  DiaryView.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject private var diaryViewModel: DiaryViewModel
    @State private var deleteMember = false
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .frame(width: 180, height: 90, alignment: .center)
                        .padding(.bottom, 50)
                        .padding(.top, 20)
                        .padding(.trailing, 18)
                    
                    Spacer()
                    
                    Menu {
                        Button("회원 탈퇴", action: {
                            deleteMember.toggle()
                        })
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.38, green: 0.93, blue: 0.84))
                    }
                    .alert("탈퇴하시겠습니까?", isPresented: $deleteMember) {
                        Button("아니오", role: .cancel) {}
                        Button("예", role: .destructive) {
                            diaryViewModel.deleteMember()
                        }
                    }
                }
                
                ScrollView {
                    HStack(spacing: 30, content: {
                        Button(action: {
                            self.changeMonth(by: -1)
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundStyle(Color(.label))
                        }
                        Text("\(diaryViewModel.currentDate, formatter: dateFormatter())")
                            .font(.title)
                            .fontWeight(.bold)
                        Button(action: {
                            self.changeMonth(by: 1)
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .foregroundStyle(Color(.label))
                        }
                    })
                    .padding()
                    
                    HStack(spacing: 0, content: {
                        ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                            Text(day)
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                                .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        }
                    })
                    
                    CalendarGridView(currentDate: $diaryViewModel.currentDate, calendars: diaryViewModel.diaryList)
                    
                    Text("월간 달성률 \(Int(diaryViewModel.monthlyPercentage * 100))%")
                        .padding(.top, 20)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    ProgressView(value: diaryViewModel.monthlyPercentage)
                        .progressViewStyle(CustomProgressViewStyle())
                        .padding(.horizontal, 50)
                        .padding(.bottom, 30)
                    
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $diaryViewModel.refreshTokenExpired) {
                SignInView(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository())))
            }
            .fullScreenCover(isPresented: $diaryViewModel.memberDeleted) {
                SignInView(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository())))
            }
            .onAppear {
                diaryViewModel.getDiaryList(date: getCurrentMonth(date: diaryViewModel.currentDate))
            }
            .padding(.horizontal, 15)
        }
    }
    
    private func changeMonth(by months: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: months, to: diaryViewModel.currentDate) {
            diaryViewModel.currentDate = newDate
            diaryViewModel.monthlyPercentage = 0.0
            diaryViewModel.getDiaryList(date: getCurrentMonth(date: diaryViewModel.currentDate))
        }
    }
    
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter
    }
    
    private func getCurrentMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let dateString = formatter.string(from: date)
        return dateString
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: geometry.size.width, height: 15)
                    .foregroundColor(Color.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: CGFloat(progress) * geometry.size.width, height: 15)
                    .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
            }
            .cornerRadius(8)
        }
    }
}


#Preview {
    DiaryView(diaryViewModel: DiaryViewModel(diaryService: DiaryService(diaryRepository: DiaryRepository()), memberService: MemberService(memberRepository: MemberRepository())))
}
