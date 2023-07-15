//
//  AppNavigator.swift
//
//  Created by snapps
//

import UIKit

class AppNavigator: NSObject {

    private let window: UIWindow
    let navigationController: UINavigationController
    private (set) var mainNavigator: MainNavigator?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        window.rootViewController = navigationController
    }

    func start() {
        showInitialStart()
    }
    
    // MARK: - Start
    
    private func showInitialStart() {
        mainNavigator = MainNavigator(navigationController: navigationController)
        mainNavigator?.start()
    }
}
