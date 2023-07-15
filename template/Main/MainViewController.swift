//
//  MainViewController.swift
//
//  Created by snapps
//

import UIKit

class MainViewController: UIPageViewController {
    
    private var weekPageViewController: WeekPageViewController?
    private var dayPageViewController: DayPageViewController?
    
    private let stackView = UIStackView.make().withNoSpacing()
        
    static func create(navigator: MainNavigatorType) -> MainViewController {
        let mainViewController = MainViewController()
        
        // Add configurations for MainViewController here
        mainViewController.dayPageViewController = DayPageViewController.create(navigator: navigator)
        mainViewController.weekPageViewController = WeekPageViewController.create(navigator: navigator)

        return mainViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .black
    }
    
    private func setupSubviews() {
        // Set up subviews here
        
        guard let weekPageViewController = weekPageViewController else { return }
        addChild(weekPageViewController)
        guard let dayPageViewController = dayPageViewController else { return }
        addChild(dayPageViewController)
        
        view.addSubviewWithoutAutoLayout(stackView)
        stackView.addArrangedSubviews([
            // Add subviews to stack
            weekPageViewController.view,
            dayPageViewController.view
        ])
    }
    
    private func setupConstraints() {
        // Add constraints to subviews here such as height constraints
        guard let weekPageView = weekPageViewController?.view else { return }
        weekPageView.height(75)
        stackView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func updateView() {
        // Update view data here
    }
    
    func updateWeekPageView(with selectedDate: Date) {
        weekPageViewController?.update(with: selectedDate)
    }
    
    func updateDayPageView(with selectedDate: Date) {
        dayPageViewController?.update(with: selectedDate)
    }
}
