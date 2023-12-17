//
//  DiaryView.swift
//  YHT
//
//  Created by 이건준 on 12/17/23.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 180, height: 90)
                .padding(.bottom, 50)
                .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    DiaryView(diaryViewModel: DiaryViewModel(diaryService: DiaryService(diaryRepository: DiaryRepository()), memberService: MemberService(memberRepository: MemberRepository())))
}
