//
//  DietView.swift
//  YHT
//
//  Created by 이건준 on 12/12/23.
//

import SwiftUI

struct DietView: View {
    @ObservedObject private var dietViewModel: DietViewModel
    let options = ["근육 증가", "체중 감량"]
    @State private var colorScheme: ColorScheme = .light
    
    init(dietViewModel: DietViewModel) {
        self.dietViewModel = dietViewModel
    }
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.bottom, 50)
                .padding(.top, 20)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20, content: {
                    HStack(spacing: 40) {
                        Text("운동 목적")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        HStack(spacing: 20, content: {
                            ForEach(options, id: \.self) { option in
                                RadioButton(selectedOption: $dietViewModel.exercisePurpose, text: option)
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
                                Picker("", selection: $dietViewModel.height) {
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
                                Picker("", selection: $dietViewModel.weight) {
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
                    
                    HStack {
                        Text("오늘 먹은 음식")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Button(action: {
                            dietViewModel.addFood = !dietViewModel.addFood
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                .scaleEffect(1.3)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    if dietViewModel.diet.count > 0 {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(dietViewModel.diet.indices, id: \.self) { index in
                                    Text(dietViewModel.diet[index])
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    
                                    Button(action: {
                                        dietViewModel.diet.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                            .scaleEffect(1.2)
                                    }
                                    .padding(.leading, -15)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    if dietViewModel.addFood {
                        VStack {
                            TextField("음식", text: $dietViewModel.food)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .padding(.leading, 30)
                                .background(Color(uiColor: .clear))
                                .overlay(
                                    HStack {
                                        Image(systemName: "fork.knife")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading),
                                    alignment: .leading
                                )
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                                    dietViewModel.addFood = !dietViewModel.addFood
                                    dietViewModel.food = ""
                                }
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                dietViewModel.diet.append(dietViewModel.food)
                                dietViewModel.food = ""
                            }) {
                                Text("추가")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                                    .foregroundColor(textColorForCurrentColorScheme())
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Button(action: {
                        dietViewModel.dietButtonClicked()
                        dietViewModel.isGptSuccess = true
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
                    
                    if dietViewModel.isGptSuccess {
                        HStack {
                            Text("추천 결과")
                                .padding(.leading, 20)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(dietViewModel.result)
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
        }
        .onTapGesture {hideKeyboard()}
            .onAppear {
                setColorScheme()
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
    DietView(dietViewModel: DietViewModel(gptService: GPTService(gptRepository: GPTRepository())))
}
