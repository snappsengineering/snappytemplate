//
//  DayPagePresenter.swift
//
//  Created by snapps
//

import Foundation

struct DayPageViewModel: Equatable {
    var selectedDate: Date
}

protocol DayPagePresenterType {
    func dateDidChange()
    func createDayViewController(for date: Date) -> DayViewController
}

class DayPagePresenter {
    
    private (set) weak var view: DayPageView?
    private (set) weak var navigator: MainNavigatorType?
    var selectedDate: Date
    
    init(view: DayPageView, navigator: MainNavigatorType, startDate: Date) {
        self.navigator = navigator
        self.view = view
        self.selectedDate = startDate
    }

    var viewModel: DayPageViewModel {
        .init(selectedDate: selectedDate)
    }

    func updateView() {
        guard let view = view else { return }
        selectedDate = view.date
        view.viewModel = viewModel
    }
}

extension DayPagePresenter: DayPagePresenterType {
    func dateDidChange() {
        updateView()
        navigator?.updateWeekPageView(selectedDate: selectedDate)
    }
    
    func createDayViewController(for date: Date) -> DayViewController {
        return DayViewController.create(navigator: navigator, date: date)
    }
}
