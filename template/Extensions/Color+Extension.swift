//
//  Color+Extension.swift
//
//  Created by snapps
//

import Foundation
import SwiftUI
import UIKit

enum Colors: String, CaseIterable {
    case accent
    case today
    case selected
    case completed
    case primaryButton
    case secondaryButton
    case primaryLabel
    case secondaryLabel
    case primaryBackground
    case secondaryBackground
    case textViewBackground
    case cellBackground
    case navigationBar
    
    func toColor() -> SwiftUI.Color {
        return SwiftUI.Color(self.rawValue)
    }
    
    func toUIColor() -> UIColor {
        return UIColor(named: self.rawValue)!
    }
}

extension Color {
    static let accent = Colors.accent.toColor()
    static let selected = Colors.selected.toColor()
    static let today = Colors.today.toColor()
    static let completed = Colors.completed.toColor()
    static let primaryButton = Colors.primaryButton.toColor()
    static let secondaryButton = Colors.secondaryButton.toColor()
    static let primaryLabel = Colors.primaryLabel.toColor()
    static let secondaryLabel = Colors.secondaryLabel.toColor()
    static let primaryBackground = Colors.primaryBackground.toColor()
    static let secondaryBackground = Colors.secondaryBackground.toColor()
    static let textViewBackground = Colors.textViewBackground.toColor()
    static let cellBackground = Colors.cellBackground.toColor()
    static let navigationBar = Colors.navigationBar.toColor()
}
