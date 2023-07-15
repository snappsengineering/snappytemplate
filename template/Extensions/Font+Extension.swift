//
//  Font+Extension.swift
//
//  Created by snapps
//

import Foundation
import SwiftUI
import UIKit

enum Fonts: String, CaseIterable {
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextMediumItalic = "AvenirNext-MediumItalic"
    case avenirNextMedium = "AvenirNext-Medium"
    case avenirNextUltraLight = "AvenirNext-UltraLight"
    case avenirNextDemiBold = "AvenirNext-DemiBold"
    case avenirNextHeavy = "AvenirNext-Heavy"
    case avenirNextItalic = "AvenirNext-Italic"
    case avenirNextBoldItalic = "AvenirNext-BoldItalic"
    case avenirNextBold = "AvenirNext-Bold"
    case hanzipenSCBold = "HanziPenSC-W5"
    
    func makeUIFont(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    func makeSwiftUIFont(size: CGFloat) -> SwiftUI.Font {
        return Font.custom(self.rawValue, size: size)
    }
}
