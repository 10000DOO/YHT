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
            Text("The First Tab")
                .tabItem {
                    Image(systemName: "list.bullet")
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
                    if selection == 2 {
                        //UnityManager.shared.show()
                    }
                }
            
        }
        .font(.headline)
    }
}

#Preview {
    MainTabView()
}
