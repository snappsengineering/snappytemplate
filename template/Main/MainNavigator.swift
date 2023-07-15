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
        self.mainViewController?.navigationItem.setImage()
        
        let calendarBarButton = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .plain,
            target: self,
            action: #selector(didToggleCalendar)
        )
        
        calendarBarButton.tintColor = .red
        
        let todayBarButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapToday)
        )
        
        todayBarButton.tintColor = .green
        
        mainViewController.navigationItem.rightBarButtonItems = [todayBarButton, calendarBarButton]
        
        navigationController.setViewControllers([mainViewController], animated: false)
        // Add additional navigation bar configurations below
        navigationController.setupBlackNavigationBar()
    }
    
    @objc func didToggleCalendar() {
        mainViewController?.didToggleCalendar()
    }
    
    @objc func didTapToday() {
        mainViewController?.updateWeekPageView(with: Date.today)
        mainViewController?.updateDayPageView(with: Date.today)
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
