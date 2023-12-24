//
//  WriteDiary.swift
//  YHT
//
//  Created by 이건준 on 12/19/23.
//

import SwiftUI

struct WriteDiary: View {
    let options = ["근력 운동", "유산소"]
    var date: String
    @State private var colorScheme: ColorScheme = .light
    @State private var deleteDiary = false
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var writeDiaryViewModel: WriteDiaryViewModel
    
    init(writeDiaryViewModel: WriteDiaryViewModel, date: String) {
        self.writeDiaryViewModel = writeDiaryViewModel
        self.date = date
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Text("오늘의 운동")
                    .font(.system(size: 35))
                    .bold()
                    .padding(.top, 20)
                
                Button(action: {
                    writeDiaryViewModel.addExercise.toggle()
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .scaleEffect(1.3)
                }
                .padding(.top, 20)
                Spacer()
                
                Button(action: {
                    deleteDiary.toggle()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .scaleEffect(1.3)
                }
                .alert("삭제하시겠습니까?", isPresented: $deleteDiary) {
                    Button("아니오", role: .cancel){}
                    Button("예", role: .destructive) {
                        writeDiaryViewModel.deleteButtonClicked()
                    }
                }
                .onReceive(writeDiaryViewModel.$deleteSucceed) { success in
                    if success {
                        dismiss()
                    }
                }
                .padding(.top, 20)
            }
            
            //작성된 운동
            if writeDiaryViewModel.exerciseInfo.count > 0 {
                VStack {
                    ForEach(writeDiaryViewModel.exerciseInfo.indices, id: \.self) { index in
                        if writeDiaryViewModel.exerciseInfo[index].cardio {
                            HStack {
                                CheckboxView(isChecked: $writeDiaryViewModel.exerciseInfo[index].finished)
                                
                                Text("\(writeDiaryViewModel.exerciseInfo[index].exerciseName) - \(writeDiaryViewModel.exerciseInfo[index].cardioTime!)분")
                                
                                Button(action: {
                                    writeDiaryViewModel.exerciseInfo.remove(at: index)
                                }) {
                                    Image(systemName: "x.circle")
                                        .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                        .scaleEffect(1.2)
                                }
                                Spacer()
                            }
                        } else {
                            HStack {
                                CheckboxView(isChecked: $writeDiaryViewModel.exerciseInfo[index].finished)
                                
                                Text("\(writeDiaryViewModel.exerciseInfo[index].exerciseName) - \(writeDiaryViewModel.exerciseInfo[index].reps!)회 \(writeDiaryViewModel.exerciseInfo[index].exSetCount!)세트")
                                
                                Button(action: {
                                    writeDiaryViewModel.exerciseInfo.remove(at: index)
                                }) {
                                    Image(systemName: "x.circle")
                                        .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                        .scaleEffect(1.2)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            //근력운동 추가
            VStack(spacing: 20) {
                if writeDiaryViewModel.addExercise {
                    HStack(spacing: 20, content: {
                        ForEach(options, id: \.self) { option in
                            RadioButton(selectedOption: $writeDiaryViewModel.exerciseType, text: option)
                        }
                        Spacer()
                    })
                }
                
                if writeDiaryViewModel.addExercise && writeDiaryViewModel.exerciseType == "근력 운동" {
                    VStack(spacing: 20) {
                        HStack {
                            Text("운동 이름 : ")
                            
                            TextField("운동 이름", text: $writeDiaryViewModel.exerciseName)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "dumbbell.fill")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                        }
                        
                        HStack {
                            TextField("횟수", text: $writeDiaryViewModel.exerciseReps)
                                .keyboardType(.numberPad)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "dumbbell.fill")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                            
                            Text("회/1세트")
                            
                            Text(" 총")
                            TextField("세트", text: $writeDiaryViewModel.exerciseSetCount)
                                .keyboardType(.numberPad)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "dumbbell.fill")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                            
                            Text("세트")
                        }
                        
                        Button(action: {
                            writeDiaryViewModel.addWeightTraining()
                            writeDiaryViewModel.exerciseName = ""
                            writeDiaryViewModel.exerciseReps = ""
                            writeDiaryViewModel.exerciseSetCount = ""
                        }) {
                            Text("추가")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                .foregroundColor(textColorForCurrentColorScheme())
                                .cornerRadius(8)
                        }
                    }
                } else if writeDiaryViewModel.addExercise && writeDiaryViewModel.exerciseType == "유산소" {
                    //유산소 추가
                    VStack(spacing: 20) {
                        HStack {
                            Text("운동 이름 : ")
                            
                            TextField("운동 이름", text: $writeDiaryViewModel.exerciseName)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "figure.run")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                            
                            Text("시간 : ")
                            
                            TextField("운동 시간", text: $writeDiaryViewModel.cardioTime)
                                .keyboardType(.numberPad)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "figure.run")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                            
                            Text("분")
                        }
                        
                        Button(action: {
                            writeDiaryViewModel.addCardio()
                            writeDiaryViewModel.exerciseName = ""
                            writeDiaryViewModel.cardioTime = ""
                        }) {
                            Text("추가")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                .foregroundColor(textColorForCurrentColorScheme())
                                .cornerRadius(8)
                        }
                    }
                }
            }
            //운동리뷰
            VStack {
                HStack {
                    Text("운동 리뷰")
                        .font(.system(size: 35))
                        .bold()
                        .padding(.top, 20)
                    
                    Button(action: {
                        writeDiaryViewModel.addReview.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                            .scaleEffect(1.3)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(.top, 200)
                .padding(.bottom, 10)
                
                if writeDiaryViewModel.addReview {
                    ZStack {
                        TextEditor(text: $writeDiaryViewModel.exerciseReview)
                            .padding(.all, 8)
                            .frame(height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 0.38, green: 0.93, blue: 0.84), lineWidth: 2)
                            )
                        
                        if writeDiaryViewModel.exerciseReview.isEmpty {
                            HStack {
                                Text("오늘의 운동은 어땠나요?")
                                    .allowsHitTesting(false)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                                    .padding(.bottom, 110)
                                
                                Spacer()
                            }
                        }
                    }
                } else {
                    if writeDiaryViewModel.exerciseReview != "" {
                        Text(writeDiaryViewModel.exerciseReview)
                            .lineLimit(nil)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.38, green: 0.93, blue: 0.84), lineWidth: 2)
                                    .padding(.horizontal, -10)
                                    .padding(.vertical, -10)
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                    }
                }
                Button(action: {
                    writeDiaryViewModel.addDiaryOrModifyDiary()
                }) {
                    Text("저장")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .foregroundColor(textColorForCurrentColorScheme())
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                .onReceive(writeDiaryViewModel.$addOrModifySucceed) { success in
                    if success {
                        dismiss()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $writeDiaryViewModel.refreshTokenExpired) {
            SignInView(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository())))
        }
        .onTapGesture {hideKeyboard()}
        .padding(.horizontal, 20)
        .onAppear {
            writeDiaryViewModel.exerciseDate = date
            writeDiaryViewModel.getDiaryDetail(date: date)
        }
        .onDisappear {
            writeDiaryViewModel.addExercise = false
            writeDiaryViewModel.isDiaryModified = false
            writeDiaryViewModel.addReview = false
            writeDiaryViewModel.refreshTokenExpired = false
            writeDiaryViewModel.addOrModifySucceed = false
            writeDiaryViewModel.deleteSucceed = false
        }
    }
    
    private func setColorScheme() {
        colorScheme = UIApplication.shared.windows.first?.rootViewController?.traitCollection.userInterfaceStyle == .dark ? .dark : .light
    }
    
    private func textColorForCurrentColorScheme() -> Color {
        return colorScheme == .light ? .white : .black
    }
}

#Preview {
    WriteDiary(writeDiaryViewModel: WriteDiaryViewModel(diaryService: DiaryService(diaryRepository: DiaryRepository()), memberService: MemberService(memberRepository: MemberRepository())), date: "2023-09-24")
}
