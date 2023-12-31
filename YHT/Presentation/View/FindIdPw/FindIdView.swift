//
//  FindIdView.swift
//  YHT
//
//  Created by 이건준 on 12/10/23.
//

import SwiftUI
import Combine

struct FindIdView: View {
    @State private var colorScheme: ColorScheme = .light
    @ObservedObject private var findIdViewModel: FindIdViewModel
    
    init(findIdViewModel: FindIdViewModel) {
        self.findIdViewModel = findIdViewModel
    }
    
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: 180, height: 90)
            .padding(.bottom, 50)
            .padding(.top, 80)

        ScrollView {
            if findIdViewModel.findedId == "" {
                VStack (alignment: .center, spacing: 20){
                    HStack {
                        TextField("이메일", text: $findIdViewModel.emailText)
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
                                findIdViewModel.isValidEmail()
                            }
                        
                        Button(action: {
                            findIdViewModel.emailButtonClick()
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
                        if findIdViewModel.emailError == ErrorMessage.availableEmail.rawValue {
                            Text(findIdViewModel.emailError)
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        } else {
                            Text(findIdViewModel.emailError)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red)
                        }
                        Spacer()
                    }
                    .padding(.top, -20)
                    .frame(height: 10)
                    
                    TextField("인증코드", text: $findIdViewModel.codeText)
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
                        Text(findIdViewModel.codeError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        Spacer()
                    }
                    .padding(.top, -20)
                    .frame(height: 10)
                    
                    VStack {
                        Button(action: {
                            findIdViewModel.findIdButtonClicked()
                        }) {
                            Text("아이디 찾기")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                            .foregroundColor(textColorForCurrentColorScheme())
                            .cornerRadius(8)
                        }
                    }
                }
            } else {
                VStack {
                    Text("아이디")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    
                    Text(findIdViewModel.findedId)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
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
    FindIdView(findIdViewModel: FindIdViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))
}
