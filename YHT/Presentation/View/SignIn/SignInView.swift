//
//  SignInView.swift
//  YHT
//
//  Created by 이건준 on 11/23/23.
//

import SwiftUI

struct SignInView: View {
    @State var id: String = ""
    @State var password: String = ""
    @State private var colorScheme: ColorScheme = .light
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 180, height: 90)
                    .padding(.bottom, 80)
                    .padding(.top, 80)
                VStack(alignment: .center, spacing: 20) {
                    TextField("아이디", text: $id)
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
                    
                    SecureField("비밀번호", text: $password)
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
                }
                
                Button(action: {
                    print("로그인")
                }) {
                    HStack {
                        Text("로그인")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                    .foregroundColor(textColorForCurrentColorScheme())
                    .cornerRadius(8)
                }.padding(.top, 70)
                
                HStack(alignment: .center, spacing: 30) {
                    Button("아이디 찾기") {
                        print("아이디 찾기")
                    }
                    .fontWeight(.bold)
                    
                    .foregroundColor(Color(.label))
                    Button("비밀번호 찾기") {
                        print("비밀번호 찾기")
                    }
                    .fontWeight(.bold)
                    
                    .foregroundColor(Color(.label))
                    NavigationLink(destination: SignUpView(signUpViewModel: SignUpViewModel())) {
                        Text("회원가입")
                            .foregroundColor(Color(.label))
                            .fontWeight(.bold)
                    }.foregroundColor(.white)
                }.padding(.top, 15)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        
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
    SignInView()
}
