//
//  WeekdayViewController.swift
//
//  Created by snapps
//

import UIKit

protocol WeekPageView: View {
    var startDate: Date { get }
    var selectedDate: Date { get set }
}

class WeekPageViewController: UIPageViewController {
    private enum Sizes {
        static let dayViewSpacing: CGFloat = 32
    }
    
    var startDate: Date = Date.today.getMonday
    var selectedDate: Date = Date.today
    
    var presenter: WeekPagePresenter?
    
    static func create(navigator: MainNavigatorType) -> WeekPageViewController {
        let weekPageViewController = WeekPageViewController(transitionStyle: .scroll,
                                                        navigationOrientation: .horizontal,
                                                        options: [UIPageViewController.OptionsKey.interPageSpacing: Sizes.dayViewSpacing])
        let presenter = WeekPagePresenter(view: weekPageViewController, navigator: navigator, startDate: weekPageViewController.startDate, selectedDate: weekPageViewController.selectedDate)
        weekPageViewController.presenter = presenter
        return weekPageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
    }
    
    private func setupView() {
        dataSource = self
        delegate = self
    }
    
    private func setupSubviews() {
        guard let weekPage = weekPage(for: startDate) else { return }
        setViewControllers([weekPage], direction: .forward, animated: true, completion: nil)
    }

    private func weekDidChange() {
        presenter?.weekDidChange()
    }
    
    func update(with selectedDate: Date) {
        self.selectedDate = selectedDate
        updateWeekPage()
    }
    
    func updateWeekPage() {
        if let currentWeekViewController = (self.viewControllers?.first as? WeekViewController) {
            currentWeekViewController.update(with: startDate, selectedDate: selectedDate)
        }
        guard !selectedDate.getMonday.hasSame(date: startDate),
              let weekPage = weekPage(for: selectedDate) else { return }
        var navigationDirection: UIPageViewController.NavigationDirection = .forward
        if selectedDate > startDate {
            navigationDirection = .forward
        } else if selectedDate < startDate {
            navigationDirection = .reverse
        }
        setViewControllers([weekPage], direction: navigationDirection, animated: true, completion: nil)
        self.startDate = selectedDate.getMonday
        weekDidChange()
    }
}

extension WeekPageViewController: WeekPageView {}

extension WeekPageViewController: UIPageViewControllerDataSource {
    private func weekPage(for date: Date) -> WeekViewController? {
        return presenter?.createWeekViewController(for: date, selectedDate: selectedDate)
    }
    
    private func getWeekAtRelative(viewController: UIViewController, position: Int) -> Date? {
        guard let selectedDay = (viewController as? WeekViewController)?.viewModel?.startDate,
              let desiredSelectedDay = Date.calendar.date(byAdding: .day, value: position, to: selectedDay) else {
            return nil
        }
        return Date.calendar.startOfDay(for: desiredSelectedDay)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let date = getWeekAtRelative(viewController: viewController, position: -7) else { return nil }
        return weekPage(for: date)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let date = getWeekAtRelative(viewController: viewController, position: 7) else { return nil }
        return weekPage(for: date)
    }
}

extension WeekPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageDate = (self.viewControllers?.first as? WeekViewController)?.viewModel?.startDate else { return }
        self.startDate = pageDate.getMonday
    }
}
