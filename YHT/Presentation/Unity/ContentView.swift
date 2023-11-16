//
//  ContentView.swift
//  YHT
//
//  Created by 이건준 on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EmptyView()
            .onAppear {
                UnityManager.shared.show()
            }
    }
}
#Preview {
    ContentView()
}
