//
//  Navigator.swift
//
//  Created by snapps
//

import UIKit

protocol NavigatorType: AnyObject {
    var navigationController: UINavigationController { get }
    var topmostViewController: UIViewController? { get }
    func showGenericErrorAlert()
    func showAlert(viewModel: AlertViewModel)
    func showAlert(title: String, message: String?, actions: [UIAlertAction])
    func start()
    func showComingSoon()
    func showComingSoon(handler: (() -> Void)?)
    func popOrDismissViewController(animated: Bool)
    func push(viewController: UIViewController, animated: Bool, backButtonText: String?)
    func push(inputNavigationController: UINavigationController, viewController: UIViewController, animated: Bool, backButtonText: String?)
    func present(viewController: UIViewController, animated: Bool)
    func pop(from inputNavigationController: UINavigationController)
}

protocol Navigator: NavigatorType {}

extension Navigator {
    func showGenericErrorAlert() {
        showAlert(viewModel: AlertViewModel())
    }
    
    func showAlert(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title,
                                      message: viewModel.message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss",
                              style: .default,
                              handler: { _ in viewModel.handler?() }))
        topmostViewController?.present(alert, animated: false, completion: nil)
    }

    func showAlert(title: String, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        topmostViewController?.present(alert, animated: false, completion: nil)
    }

    func showComingSoon() {
        showComingSoon(handler: nil)
    }

    func showComingSoon(handler: (() -> Void)?) {
        let title = NSLocalizedString("Coming Soon", comment: "Coming soon alert title")
        let message = NSLocalizedString("This feature is not implemented yet", comment: "Coming soon alert message")
        showAlert(viewModel: AlertViewModel(title: title, message: message, handler: handler))
    }

    var topmostViewController: UIViewController? {
        return UIApplication.topViewController(controller: navigationController)
    }

    func popOrDismissViewController(animated: Bool = true) {
        if let presentedNavigationController = topmostViewController as? UINavigationController,
           presentedNavigationController.viewControllers.count > 1 {
            presentedNavigationController.popViewController(animated: animated)
        } else {
            topmostViewController?.dismiss(animated: animated)
        }
    }
    
    func push(viewController: UIViewController, animated: Bool, backButtonText: String?) {
        let item = UIBarButtonItem(title: backButtonText, style: .plain, target: nil, action: nil)
        navigationController.visibleViewController?.navigationItem.backBarButtonItem = item
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        navigationController.visibleViewController?.present(viewController, animated: animated, completion: nil)
    }
    
    // Convinience
    func push(
        _ viewController: UIViewController,
        hideNavigationBar: Bool = false,
        hideBottomBar: Bool = true,
        animated: Bool = false,
        backButtonText: String? = nil
    ) {
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        navigationController.setNavigationBarHidden(hideNavigationBar, animated: animated)
        push(viewController: viewController, animated: animated, backButtonText: backButtonText)
    }
    
    func push(inputNavigationController: UINavigationController, viewController: UIViewController, animated: Bool, backButtonText: String?) {
        let item = UIBarButtonItem(title: backButtonText, style: .plain, target: nil, action: nil)
        inputNavigationController.visibleViewController?.navigationItem.backBarButtonItem = item
        inputNavigationController.pushViewController(viewController, animated: animated)
    }
    
    // Convinience
    func push(
        _ inputNavigationController: UINavigationController,
        viewController: UIViewController,
        hideNavigationBar: Bool = false,
        hideBottomBar: Bool = true,
        animated: Bool = false,
        backButtonText: String? = nil
    ) {
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        inputNavigationController.setNavigationBarHidden(hideNavigationBar, animated: animated)
        push(inputNavigationController: inputNavigationController, viewController: viewController, animated: animated, backButtonText: backButtonText)
    }
    
    func pop(from inputNavigationController: UINavigationController) {
        inputNavigationController.popViewController(animated: true)
    }
}

struct AlertViewModel: Equatable {
    var title: String = "Something went wrong"
    var message: String = "Try again later"
    var handler: (() -> Void)?
    
    static func == (lhs: AlertViewModel, rhs: AlertViewModel) -> Bool {
        lhs.title == rhs.title && lhs.message == rhs.message
    }
}
