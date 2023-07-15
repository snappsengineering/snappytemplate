//
//  WeekBannerView.swift
//
//  Created by snapps
//

import UIKit

struct WeekBannerViewModel: Equatable {
    static func == (lhs: WeekBannerViewModel, rhs: WeekBannerViewModel) -> Bool {
        lhs.dates == rhs.dates &&
        lhs.selectedDate == rhs.selectedDate
    }
    
    var dates: [Date]
    var selectedDate: Date
    
    var didTapWeekday: (Date) -> Void
}

class WeekBannerView: UIView {
    
    private enum Insets {
        static let stackView = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

    private let stackView = UIStackView.make().with(axis: .horizontal).with(distribution: .fillEqually)
    
    var viewModel: WeekBannerViewModel? {
        didSet {
            guard viewModel != oldValue else { return }
            updateView()
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupSubviews()
        setupConstraints()
    }
        
    private func setupSubviews() {
        addSubviewWithoutAutoLayout(stackView)
    }
    
    private func setupConstraints() {
        stackView.edgesToSuperview(Insets.stackView)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        stackView.removeAllArrangedSubviews()
        for date in viewModel.dates {
            let weekdayItem = WeekDayItem()
            weekdayItem.viewModel = WeekDayItemViewModel(
                isSelected: viewModel.selectedDate == date,
                date: date,
                buttonAction: { [weak self] tappedDate in
                    self?.viewModel?.didTapWeekday(tappedDate)
                }
            )
            stackView.addArrangedSubview(weekdayItem)
        }
    }
}
