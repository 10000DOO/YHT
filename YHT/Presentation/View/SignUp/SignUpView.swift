//
//  SignUpView.swift
//  YHT
//
//  Created by 이건준 on 11/23/23.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }.navigationBarHidden(true)
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
