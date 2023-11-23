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
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.top, 25)
            
            VStack {
                TextField("아이디 입력", text: $id)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 20)
                    .background(Color(uiColor: .clear))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
                
                SecureField("비밀번호 입력", text: $password)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 20)
                    .background(Color(uiColor: .clear))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)), lineWidth: 1))
            }
            .padding(.horizontal, 20)
            .padding(.top, 120)
        }
        
        VStack {
            Button(action: {
                print("로그인")
            }) {
                HStack {
                    Text("로그인")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
                .foregroundColor(textColorForCurrentColorScheme())
                .cornerRadius(8)
            }
            
            HStack(alignment: .center, spacing: 20) {
                Button("아이디 찾기") {
                    print("아이디 찾기")
                }
                .foregroundColor(Color(.label))
                Button("비밀번호 찾기") {
                    print("비밀번호 찾기")
                }
                .foregroundColor(Color(.label))
                Button("회원가입") {
                    print("회원가입")
                }
                .foregroundColor(Color(.label))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 50)
        Spacer()
        
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
