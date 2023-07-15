//
//  AppDelegate.swift
//  template
//
//  Created by Shane Noormohamed on 7/15/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: AppNavigator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
                self.window = window
                window.makeKeyAndVisible()
                
                navigator = AppNavigator(window: window)
                navigator?.start()
        
        return true
    }
}

