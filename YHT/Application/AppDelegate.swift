//
//  AppDelegate.swift
//  YHT
//
//  Created by 이건준 on 11/14/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UnityManager.shared.setHostMainWindow(window)
        
        return true
    }
}

