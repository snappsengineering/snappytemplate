//
//  View.swift
//
//  Created by snapps
//

import Foundation
import UIKit

protocol View: AnyObject {
    func showActivity()
    func hideActivity()
    
    func present(_ controller: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
}

extension View {
    func showActivity() {}

    func hideActivity() {}
    
    func present(_ controller: UIViewController, animated: Bool = true) {
        (self as? UIViewController)?.present(controller, animated: animated)
    }

    func dismiss(animated: Bool = true) {
        (self as? UIViewController)?.dismiss(animated: animated, completion: nil)
    }
}

protocol ContentsRefreshable: AnyObject {
    func refreshContent()
}

protocol RefreshView: View {
    func showRefreshControl()
    func hideRefreshControl()
}
