//
//  UINavigationController+Extensions.swift
//
//  Created by snapps
//

import UIKit

extension UINavigationController {
    
    func setupTransparentNavigationBar() {
        // Make the navigation bar background clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func setupBlackNavigationBar() {
        navigationBar.barTintColor = .black
        navigationBar.isTranslucent = false
    }
}
