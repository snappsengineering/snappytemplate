//
//  WeekViewController.swift
//
//  Created by snapps
//

import UIKit

protocol WeekView: View {
    var viewModel: WeekViewModel? { get set }
}

class WeekViewController: UIViewController {
    
    private enum Insets {
        static let bannerInsets = UIEdgeInsets.zero
    }
    
    private let weekBannerView = WeekBannerView()
        
    var presenter: WeekPresenter?
    var viewModel: WeekViewModel? {
        didSet {
            updateView()
        }
    }
    
    static func create(navigator: MainNavigatorType?, startDate: Date, selectedDate: Date) -> WeekViewController {
        let weekViewController = WeekViewController()
        weekViewController.presenter = WeekPresenter(view: weekViewController,
                                                     navigator: navigator,
                                                     startDate: startDate,
                                                     selectedDate: selectedDate)
        return weekViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    private func setupSubviews() {
        view.addSubviewWithoutAutoLayout(weekBannerView)
    }
    
    private func setupConstraints() {
        weekBannerView.edgesToSuperview(Insets.bannerInsets)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        weekBannerView.viewModel = WeekBannerViewModel(dates: viewModel.selectedWeek,
                                                       selectedDate: viewModel.selectedDate,
                                                       didTapWeekday: { [weak self] tappedDate in
            self?.presenter?.didTapWeekday(with: tappedDate)
        })
    }
    
    func update(with startDate: Date, selectedDate: Date) {
        presenter?.selectedDateDidChange(with: startDate, selectedDate: selectedDate)
    }
}

extension WeekViewController: WeekView {}
