//
//  YHTApp.swift
//  YHT
//
//  Created by 이건준 on 11/17/23.
//

import SwiftUI

@main
struct YHTApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isAlreadySignIn") {
                MainTabView()
            } else {
                SignInView(signInViewModel: SignInViewModel(memberService: MemberService(memberRepository: MemberRepository())))
            }
        }
    }
}
