//
//  SignInView.swift
//  YHT
//
//  Created by 이건준 on 11/23/23.
//

import SwiftUI

struct SignInView: View {
    @State private var colorScheme: ColorScheme = .light
    @ObservedObject private var signInViewModel: SignInViewModel
    
    init(signInViewModel: SignInViewModel) {
        self.signInViewModel = signInViewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 180, height: 90)
                    .padding(.bottom, 80)
                    .padding(.top, 80)
                VStack(alignment: .center, spacing: 30) {
                    TextField("아이디", text: $signInViewModel.id)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 30)
                        .background(Color(uiColor: .clear))
                        .overlay(
                            HStack {
                                Image(systemName: "person.fill.viewfinder")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                                .frame(maxWidth: .infinity, alignment: .leading),
                            alignment: .leading
                        )
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                    
                    SecureField("비밀번호", text: $signInViewModel.password)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 30)
                        .background(Color(uiColor: .clear))
                        .overlay(
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                                .frame(maxWidth: .infinity, alignment: .leading),
                            alignment: .leading
                        )
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                    
                    HStack {
                        Text(signInViewModel.signInError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        Spacer()
                    }
                    .padding(.top, -20)
                    .frame(height: 10)
                }
                
                Button(action: {
                    signInViewModel.signInButtonClicked()
                }) {
                    Text("로그인")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .foregroundColor(textColorForCurrentColorScheme())
                        .cornerRadius(8)
                        .onReceive(signInViewModel.$signInSuccess) { success in
                            if success {
                                UserDefaults.standard.set(true, forKey: "isAlreadySignIn")
                            }
                        }
                }
                .padding(.top, 60)
                .fullScreenCover(isPresented: $signInViewModel.signInSuccess) {
                    MainTabView()
                }
                
                HStack(alignment: .center, spacing: 30) {
                    NavigationLink(destination: FindIdView(findIdViewModel: FindIdViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))) {
                        Text("아이디 찾기")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                    }.foregroundColor(.white)
                    
                    NavigationLink(destination: FindPwView(findPwViewModel: FindPwViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))) {
                        Text("비밀번호 찾기")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                    }.foregroundColor(.white)
                    
                    NavigationLink(destination: SignUpView(signUpViewModel: SignUpViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))) {
                        Text("회원가입")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                    }.foregroundColor(.white)
                }.padding(.top, 15)
                Spacer()
                
            }
            .padding(.horizontal, 20)
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
    SignInView(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository())))
}
