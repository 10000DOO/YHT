//
//  RoutineView.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject private var routineViewModel: RoutineViewModel
    let options = ["근육 증가", "체중 감량"]
    @State private var colorScheme: ColorScheme = .light
 
    init(routineViewModel: RoutineViewModel) {
        self.routineViewModel = routineViewModel
    }
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.bottom, 50)
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 20, content: {
                    HStack(spacing: 40) {
                        Text("운동 목적")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        HStack(spacing: 20, content: {
                            ForEach(options, id: \.self) { option in
                                RadioButton(selectedOption: $routineViewModel.exercisePurpose, text: option)
                            }
                        })
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    HStack(spacing: 40) {
                        Text("키·몸무게")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        
                        HStack(spacing: 20) {
                            HStack(spacing: -10) {
                                Picker("", selection: $routineViewModel.height) {
                                    ForEach(0..<231) { number in
                                        Text("\(number)")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(height: 130)
                                .frame(width: 60)
                                
                                Text("CM")
                                    .font(.system(size: 15))
                                    .frame(width: 25)
                                    .fontWeight(.bold)
                            }
                            
                            HStack(spacing: -10) {
                                Picker("", selection: $routineViewModel.weight) {
                                    ForEach(0..<151) { number in
                                        Text("\(number)")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(height: 130)
                                .frame(width: 60)
                                
                                Text("KG")
                                    .font(.system(size: 15))
                                    .frame(width: 25)
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    HStack(spacing: 40) {
                        Text("운동 분할")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        HStack(spacing: -10) {
                            Picker("", selection: $routineViewModel.divisions) {
                                ForEach(0..<6) { number in
                                    Text("\(number)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 130)
                            .frame(width: 60)
                            
                            Text("일")
                                .font(.system(size: 15))
                                .frame(width: 25)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    Button(action: {
                        routineViewModel.routineButtonClicked()
                        routineViewModel.isGptSuccess = true
                    }) {
                        Text("추천 받기")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                            .foregroundColor(textColorForCurrentColorScheme())
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    
                    if routineViewModel.isGptSuccess {
                        HStack {
                            Text("추천 결과")
                                .padding(.leading, 20)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(routineViewModel.result)
                            .lineLimit(nil)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.38, green: 0.93, blue: 0.84), lineWidth: 2)
                                    .padding(.horizontal, -10)
                                    .padding(.vertical, -10)
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                    }
                })
            }
            .onAppear {
                setColorScheme()
            }
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
    RoutineView(routineViewModel: RoutineViewModel(gptService: GPTService(gptRepository: GPTRepository())))
}
