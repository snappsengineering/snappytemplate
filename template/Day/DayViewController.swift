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
    
    private enum Insets {
        static let tableView = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    private enum Sizes {
        static let stackViewSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 20
    }
    
    private var dayHeaderView = DayHeaderView()
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
    }
    
    private func setupConstraints() {
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        dayHeaderView.viewModel = viewModel.dayHeaderViewModel
    }
}

extension DayViewController: DayView {}

extension DayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dayHeaderView
    }
}
