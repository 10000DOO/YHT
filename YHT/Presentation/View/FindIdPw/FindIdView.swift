//
//  FindIdPwView.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import SwiftUI
import Combine

struct FindIdPwView: View {
    @State private var colorScheme: ColorScheme = .light
    @ObservedObject private var findIdPwViewModel: FindIdPwViewModel
    
    init(findIdPwViewModel: FindIdPwViewModel) {
        self.findIdPwViewModel = findIdPwViewModel
    }
    
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: 180, height: 90)
            .padding(.bottom, 50)
            .padding(.top, 80)
        ScrollView {
            VStack (alignment: .center, spacing: 20){
                HStack {
                    TextField("이메일", text: $findIdPwViewModel.emailText)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 30)
                        .background(Color(uiColor: .clear))
                        .overlay(
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                                .frame(maxWidth: .infinity, alignment: .leading),
                            alignment: .leading
                        )
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                            findIdPwViewModel.isValidEmail()
                        }
                    
                    Button(action: {
                        findIdPwViewModel.emailButtonClick()
                    }) {
                        Text("코드 발송")
                        .fontWeight(.bold)
                        .frame(height: 50)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .foregroundColor(textColorForCurrentColorScheme())
                        .cornerRadius(8)
                    }
                }
                
                HStack {
                    if findIdPwViewModel.emailError == ErrorMessage.availableEmail.rawValue {
                        Text(findIdPwViewModel.emailError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(findIdPwViewModel.emailError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }
                .padding(.top, -20)
                .frame(height: 10)
                
                TextField("인증코드", text: $findIdPwViewModel.codeText)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 30)
                    .background(Color(uiColor: .clear))
                    .overlay(
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                            Spacer()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading),
                        alignment: .leading
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                
                HStack {
                    Text(findIdPwViewModel.codeError)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                    Spacer()
                }
                .padding(.top, -20)
                .frame(height: 10)
                
                
                
                VStack {
                    Button(action: {
                        print("인증")
                    }) {
                        Text("인증코드 확인")
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
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .background(textColorForCurrentColorScheme())
        .onTapGesture {hideKeyboard()}
        .onAppear {
            setColorScheme()
        }
    }
    
    private func setColorScheme() {
        colorScheme = UIApplication.shared.windows.first?.rootViewController?.traitCollection.userInterfaceStyle == .light ? .dark : .light
    }
    
    private func textColorForCurrentColorScheme() -> Color {
        return colorScheme == .light ? .black : .white
    }
}

#Preview {
    FindIdPwView(findIdPwViewModel: FindIdPwViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))
}
