//
//  SignUpView.swift
//  YHT
//
//  Created by 이건준 on 11/23/23.
//

import SwiftUI

struct SignUpView: View {
    @State var emailText: String = ""
    @State var codeText: String = ""
    @State var usernameText: String = ""
    @State var passwordText: String = ""
    @State var confirmPasswordText: String = ""
    @State var idText: String = ""
    @State var emailError: String = ""
    @State var idError: String = ""
    @State var passwordError: String = ""
    @State var passwordCheckError: String = ""
    @State var isCodeTextFieldVisible: Bool = false
    @State private var colorScheme: ColorScheme = .light
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.bottom, 50)
                .padding(.top, 80)
            HStack {
                TextField("이메일", text: $emailText)
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
                
                Button(action: {
                    isCodeTextFieldVisible = true
                }) {
                    HStack {
                        Text("코드 발송")
                            .fontWeight(.bold)
                    }
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .foregroundColor(textColorForCurrentColorScheme())
                    .cornerRadius(8)
                }
            }
            
            HStack {
                Text($emailError.wrappedValue)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.red))
                Spacer()
            }.padding(.top, -20)
                .frame(height: 10)
            
            if isCodeTextFieldVisible {
                TextField("인증 코드", text: $codeText)
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
                
                Text("")
                    .padding(.top, -20)
                        .frame(height: 10)
            }
            
            TextField("아이디", text: $idText)
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
            
            HStack {
                Text($idError.wrappedValue)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.red))
                Spacer()
            }.padding(.top, -20)
                .frame(height: 10)
            
            TextField("비밀번호", text: $passwordText)
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
                Text($passwordError.wrappedValue)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.red))
                Spacer()
            }.padding(.top, -20)
                .frame(height: 10)
            
            TextField("비밀번호 확인", text: $confirmPasswordText)
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
                Text($passwordCheckError.wrappedValue)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.red))
                Spacer()
            }.padding(.top, -20)
                .frame(height: 10)
            
            Spacer()
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
    SignUpView()
}
