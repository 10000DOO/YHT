//
//  TabView.swift
//  YHT
//
//  Created by 이건준 on 12/11/23.
//

import SwiftUI

struct TabView: View {
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
              Text("The First Tab")
                .badge(10)
                .tabItem {
                  Image(systemName: "1.square.fill")
                  Text("First")
                }
                .tag(1)
              Text("Another Tab")
                .badge(20)
                .tabItem {
                  Image(systemName: "2.square.fill")
                  Text("Second")
                }
                .tag(2)
              Text("The Last Tab")
                .badge(30)
                .tabItem {
                  Image(systemName: "3.square.fill")
                  Text("Third")
                }
                .tag(3)
            }
            .font(.headline)
    }
}

#Preview {
    TabView()
}
