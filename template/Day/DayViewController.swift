//
//  DayViewController.swift
//
//  Created by snapps
//

import UIKit

protocol DayView: View {
    var viewModel: DayViewModel? { get set }
}

class DayViewController: UIViewController {
    
    private enum Sizes {
        static let stackViewSpacing: CGFloat = 8
    }
    
    private var dayHeaderView = DayHeaderView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView.make().with(spacing: Sizes.stackViewSpacing)
        
    var presenter: DayPresenter?
    var viewModel: DayViewModel? {
        didSet {
            updateView()
        }
    }
    
    static func create(navigator: MainNavigatorType?, date: Date) -> DayViewController {
        let dayViewController = DayViewController()
        dayViewController.presenter = DayPresenter(view: dayViewController,
                                                   navigator: navigator,
                                                   date: date)
        return dayViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    private func setupView() {
        
    }
    
    private func setupSubviews() {
        view.addSubviewWithoutAutoLayout(scrollView)
        scrollView.addSubviewWithoutAutoLayout(stackView)
        stackView.addArrangedSubviews([
            // Add subviews to stack
            dayHeaderView
        ])
    }
    
    private func setupConstraints() {
        scrollView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        dayHeaderView.viewModel = viewModel.dayHeaderViewModel
    }
}

extension DayViewController: DayView {}
