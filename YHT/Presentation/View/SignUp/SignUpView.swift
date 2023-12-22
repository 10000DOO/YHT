//
//  SignUpView.swift
//  YHT
//
//  Created by 이건준 on 11/23/23.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @State private var colorScheme: ColorScheme = .light
    @ObservedObject private var signUpViewModel: SignUpViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel
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
                    TextField("이메일", text: $signUpViewModel.emailText)
                        .keyboardType(.emailAddress)
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
                            signUpViewModel.isValidEmail()
                        }
                    
                    Button(action: {
                        signUpViewModel.isCodeTextFieldVisible = true
                        signUpViewModel.emailButtonClick()
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
                    if signUpViewModel.emailError == ErrorMessage.availableEmail.rawValue {
                        Text(signUpViewModel.emailError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(signUpViewModel.emailError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }
                .padding(.top, -20)
                .frame(height: 10)
                
                if signUpViewModel.isCodeTextFieldVisible {
                    TextField("인증코드", text: $signUpViewModel.codeText)
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
                        Text(signUpViewModel.codeError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                        Spacer()
                    }
                    .padding(.top, -20)
                    .frame(height: 10)
                }
                
                TextField("아이디", text: $signUpViewModel.idText)
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
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                        signUpViewModel.isValidId()
                    }
                
                HStack {
                    if signUpViewModel.idError == ErrorMessage.availableLoginId.rawValue {
                        Text(signUpViewModel.idError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(signUpViewModel.idError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }.padding(.top, -20)
                    .frame(height: 10)
                
                SecureField("비밀번호", text: $signUpViewModel.passwordText)
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
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                        signUpViewModel.isValidPassword()
                    }
                
                HStack {
                    if signUpViewModel.passwordError == ErrorMessage.availablePassword.rawValue {
                        Text(signUpViewModel.passwordError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(signUpViewModel.passwordError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }.padding(.top, -20)
                    .frame(height: 10)
                
                SecureField("비밀번호 확인", text: $signUpViewModel.confirmPasswordText)
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
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                        signUpViewModel.isValidPasswordCheck()
                    }
                
                HStack {
                    if signUpViewModel.passwordCheckError == ErrorMessage.passwordMatching.rawValue {
                        Text(signUpViewModel.passwordCheckError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(signUpViewModel.passwordCheckError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }.padding(.top, -20)
                    .frame(height: 10)
                
                TextField("닉네임", text: $signUpViewModel.usernameText)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 30)
                    .background(Color(uiColor: .clear))
                    .overlay(
                        HStack {
                            Image(systemName: "textformat.size")
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                            Spacer()
                        }
                            .frame(maxWidth: .infinity, alignment: .leading),
                        alignment: .leading
                    )
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                        signUpViewModel.isValidNickname()
                    }
                
                HStack {
                    if signUpViewModel.usernameError == ErrorMessage.availableNickName.rawValue {
                        Text(signUpViewModel.usernameError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    } else {
                        Text(signUpViewModel.usernameError)
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }.padding(.top, -20)
                    .frame(height: 10)
                
                VStack {
                    Button(action: {
                        signUpViewModel.signUpButtonClicked()
                    }) {
                        Text("회원가입")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                        .foregroundColor(textColorForCurrentColorScheme())
                        .cornerRadius(8)
                    }
                }
                .onReceive(signUpViewModel.$signUpSuccess) { success in
                    if success {
                        dismiss()
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

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#Preview {
    SignUpView(signUpViewModel: SignUpViewModel(emailService: EmailService(emailRepository: EmailRepository()), memberService: MemberService(memberRepository: MemberRepository())))
}
