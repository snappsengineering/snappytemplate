//
//  MainNavigator.swift
//
//  Created by snapps
//

import UIKit

protocol MainNavigatorType: Navigator {
    func updateWeekPageView(selectedDate: Date)
    func updateDayPageView(selectedDate: Date)
}

class MainNavigator: NSObject, Navigator {

    let navigationController: UINavigationController
    private (set) weak var mainViewController: MainViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainViewController.create(navigator: self)
        self.mainViewController = mainViewController
        
        navigationController.setViewControllers([mainViewController], animated: false)
        // Add additional navigation bar configurations below
        navigationController.setupBlackNavigationBar()
    }
}

extension MainNavigator: MainNavigatorType {
    func updateWeekPageView(selectedDate: Date) {
        mainViewController?.updateWeekPageView(with: selectedDate)
    }
    
    func updateDayPageView(selectedDate: Date) {
        mainViewController?.updateDayPageView(with: selectedDate)
    }
}
