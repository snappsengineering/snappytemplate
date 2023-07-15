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
    
    private var topLabel = UILabel.make()
        .with(font: Fonts.avenirNextBold.makeUIFont(size: 18))
        .with(textAlignment: .center)
    
    private var bottomLabel = UILabel.make()
        .with(font: Fonts.avenirNextBold.makeUIFont(size: 16))
        .with(textAlignment: .center)
    
    private lazy var itemButton = UIButton.make { [weak self] in
        guard let viewModel = self?.viewModel else { return }
        viewModel.buttonAction(viewModel.date)
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
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        backgroundColor = .lightGray
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    private func setupSubviews() {
        addSubviewWithoutAutoLayout(topLabel)
        addSubviewWithoutAutoLayout(bottomLabel)
        addSubviewWithoutAutoLayout(itemButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 4),
            
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        topLabel.setContentHuggingPriority(.required, for: .vertical)
        bottomLabel.setContentHuggingPriority(.required, for: .vertical)
        
        itemButton.edgesToSuperview()
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        topLabel.text = viewModel.date.shortDayOfWeek().lowercased()
        bottomLabel.text = viewModel.date.dayOfMonth()
        
        if viewModel.date.isToday() {
            topLabel.textColor = .green
            bottomLabel.textColor = .white
        } else if viewModel.isSelected && !viewModel.date.isToday() {
            topLabel.textColor = .yellow
            bottomLabel.textColor = .white
        } else {
            topLabel.textColor = .darkGray
            bottomLabel.textColor = .darkGray
        }
    }
}
