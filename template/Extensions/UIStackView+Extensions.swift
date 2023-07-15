//
//  UIStackView+Extensions.swift
//
//  Created by snapps
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }

    func addSpacerViews(count: Int) {
        guard count > 0 else { return }
        for _ in 1...count { addArrangedSubview(UIView()) }
    }
}
