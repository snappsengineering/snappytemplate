//
//  DayPageViewController.swift
//
//  Created by snapps
//

import UIKit

protocol DayPageView: View {
    var viewModel: DayPageViewModel? { get set }
    var date: Date { get set }
}

class DayPageViewController: UIPageViewController {
    var date: Date = Date.today
    
    private enum Sizes {
        static let dayViewSpacing: CGFloat = 32
    }
    
    var presenter: DayPagePresenterType?
    var viewModel: DayPageViewModel?
    
    static func create(navigator: MainNavigatorType) -> DayPageViewController {
        let dayPageViewController = DayPageViewController(transitionStyle: .scroll,
                                                        navigationOrientation: .horizontal,
                                                        options: [UIPageViewController.OptionsKey.interPageSpacing: Sizes.dayViewSpacing])
        let presenter = DayPagePresenter(view: dayPageViewController, navigator: navigator, startDate: dayPageViewController.date)
        dayPageViewController.presenter = presenter
        return dayPageViewController
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
        guard let dayPage = dayPage(for: date) else { return }
        setViewControllers([dayPage], direction: .forward, animated: true, completion: nil)
    }
    
    private func dateDidChange() {
        presenter?.dateDidChange()
    }
    
    func update(with selectedDate: Date) {
        guard !selectedDate.hasSame(date: date),
              let dayPage = dayPage(for: selectedDate) else { return }
        var navigationDirection: UIPageViewController.NavigationDirection = .forward
        if selectedDate > date {
            navigationDirection = .forward
        } else if selectedDate < date {
            navigationDirection = .reverse
        }
        setViewControllers([dayPage], direction: navigationDirection, animated: true, completion: nil)
        self.date = selectedDate
        dateDidChange()
    }
}

extension DayPageViewController: DayPageView {}

extension DayPageViewController: UIPageViewControllerDataSource {
    private func dayPage(for date: Date) -> DayViewController? {
        return presenter?.createDayViewController(for: date)
    }
    
    private func getDayAtRelative(viewController: UIViewController, position: Int) -> Date? {
        guard let day = (viewController as? DayViewController)?.viewModel?.date,
              let desiredDay = Date.calendar.date(byAdding: .day, value: position, to: day) else {
            return nil
        }
        return Date.calendar.startOfDay(for: desiredDay)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let date = getDayAtRelative(viewController: viewController, position: -1) else { return nil }
        return dayPage(for: date)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let date = getDayAtRelative(viewController: viewController, position: 1) else { return nil }
        return dayPage(for: date)
    }
}

extension DayPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageDate = (self.viewControllers?.first as? DayViewController)?.viewModel?.date else { return }
        self.date = pageDate
        dateDidChange()
    }
}
