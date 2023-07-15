//
//  WeekDayItem.swift
//
//  Created by snapps
//

import UIKit

struct WeekDayItemViewModel: Equatable {
    static func == (lhs: WeekDayItemViewModel, rhs: WeekDayItemViewModel) -> Bool {
        lhs.date == rhs.date &&
        lhs.isSelected == rhs.isSelected
    }
    
    var isSelected: Bool
    var date: Date
    var buttonAction: (Date) -> Void
}

class WeekDayItem: UIView {
    
    var viewModel: WeekDayItemViewModel? {
        didSet {
            guard viewModel != oldValue else { return }
            updateView()
        }
    }
    
    private var topLabel = UILabel.make().with(font: Fonts.avenirNextBold.makeUIFont(size: 18))
    private var bottomLabel = UILabel.make().with(font: Fonts.avenirNextMedium.makeUIFont(size: 16))
    private lazy var itemButton = UIButton.make { [weak self] in
        guard let viewModel = self?.viewModel else { return }
        viewModel.buttonAction(viewModel.date)
    }
    private let stackView = UIStackView.make().with(alignment: .center)
    
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
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {}
    
    private func setupSubviews() {
        addSubviewWithoutAutoLayout(stackView)
        stackView.addArrangedSubviews(
            [
                topLabel,
                bottomLabel
            ]
        )
        addSubviewWithoutAutoLayout(itemButton)
    }
    
    private func setupConstraints() {
        stackView.edgesToSuperview()
        itemButton.edgesToSuperview()
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        topLabel.text = viewModel.date.shortDayOfWeek().lowercased()
        bottomLabel.text = viewModel.date.dayOfMonth()
        if viewModel.date.isToday() {
            topLabel.textColor = .blue
            bottomLabel.textColor = .lightGray
        } else if viewModel.isSelected && !viewModel.date.isToday() {
            topLabel.textColor = .yellow
            bottomLabel.textColor = .lightGray
        } else {
            topLabel.textColor = .darkGray
            bottomLabel.textColor = .darkGray
        }
    }
}