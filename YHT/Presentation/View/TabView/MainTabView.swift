//
//  MainTabView.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            RoutineView(routineViewModel: RoutineViewModel(gptService: GPTService(gptRepository: GPTRepository())))
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("루틴 추천")
                }
                .tag(1)
            
            
            Text("")
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("AR")
                }
                .tag(2)
                .onAppear {
                    if selection == 3 {
                        //UnityManager.shared.show()
                    }
                }
            
            DietView(dietViewModel: DietViewModel(gptService: GPTService(gptRepository: GPTRepository())))
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("식단 추천")
                }
                .tag(3)
            
            ReviewView(reviewViewModel: ReviewViewModel(gptService: GPTService(gptRepository: GPTRepository())))
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("운동 피드백")
                }
                .tag(4)
            
        }
        .font(.headline)
        .accentColor(Color(#colorLiteral(red: 0.38, green: 0.93, blue: 0.84, alpha: 1)))
    }
}

#Preview {
    MainTabView()
}
