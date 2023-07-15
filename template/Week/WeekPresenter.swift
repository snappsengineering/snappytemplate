//
//  WeekdayPresenter.swift
//
//  Created by snapps
//

import Foundation

struct WeekViewModel: Equatable {
    var startDate: Date
    var selectedDate: Date
    
    var selectedWeek: [Date] {
        var dates = [Date]()
        for day in 0..<7 {
            guard let nextDate = Date.calendar.date(byAdding: .day, value: day, to: startDate.getMonday) else { return dates }
            dates.append(nextDate)
        }
        return dates
    }
}

class WeekPresenter {
    
    private (set) weak var view: WeekView?
    private (set) weak var navigator: MainNavigatorType?
    private (set) var startDate: Date
    private (set) var selectedDate: Date = Date.today
    
    init(view: WeekView, navigator: MainNavigatorType?, startDate: Date, selectedDate: Date) {
        self.navigator = navigator
        self.view = view
        self.startDate = startDate
        self.selectedDate = selectedDate
    }

    var viewModel: WeekViewModel {
        .init(startDate: startDate, selectedDate: selectedDate)
    }
    
    func viewWillAppear() {
        updateView()
    }

    func updateView() {
        view?.viewModel = viewModel
    }
    
    func selectedDateDidChange(with startDate: Date, selectedDate: Date) {
        self.startDate = startDate
        self.selectedDate = selectedDate
        updateView()
    }
    
    func didTapWeekday(with tappedDate: Date) {
        navigator?.updateDayPageView(selectedDate: tappedDate)
    }
}

