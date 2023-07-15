//
//  UINavigationItem+Extensions.swift
//
//  Created by snapps
//
 
import UIKit

extension UINavigationItem {
    func setTitle() {
        let navLabel = UILabel()
        
        let navTitle = NSMutableAttributedString(string: "T", attributes:[
            NSAttributedString.Key.font: Fonts.hanzipenSCBold.makeUIFont(size: 24),
                                                    NSAttributedString.Key.foregroundColor: UIColor.cyan])

        navTitle.append(NSMutableAttributedString(string: "emplate", attributes:[
            NSAttributedString.Key.font: Fonts.avenirNextMediumItalic.makeUIFont(size: 19),
            NSAttributedString.Key.foregroundColor: UIColor.white]))

        navLabel.attributedText = navTitle
        self.titleView = navLabel
    }
    
    func setImage() {
        let image = UIImage(named: "se_nav")
        self.titleView = UIImageView(image: image)
    }
}
