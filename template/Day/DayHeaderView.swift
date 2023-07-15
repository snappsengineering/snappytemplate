//
//  DayHeaderView.swift
//
//  Created by snapps
//

import UIKit

struct DayHeaderViewModel: Equatable {
    var dayString: String
    var dateString: String
    var isToday: Bool
}

class DayHeaderView: UIView {
    
    private enum Insets {
        static let stackView = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    private var dayLabel = UILabel.make().with(textColor: .white).with(font: Fonts.avenirNextBold.makeUIFont(size: 28))
    private var dateLabel = UILabel.make().with(textColor: .gray).with(font: Fonts.avenirNextRegular.makeUIFont(size: 20))
    private let stackView = UIStackView.make()
    
    var viewModel: DayHeaderViewModel? {
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
        
        stackView.addArrangedSubviews([
            dayLabel,
            dateLabel
        ])
    }
    
    private func setupConstraints() {
        stackView.edgesToSuperview(Insets.stackView)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        dayLabel.text = viewModel.dayString
        dateLabel.text = viewModel.dateString
        dayLabel.textColor = viewModel.isToday ? .blue : .white
    }
}
