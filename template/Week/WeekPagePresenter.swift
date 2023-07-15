//
//  WeekPagePresenter.swift
//
//  Created by snapps
//

import Foundation

class WeekPagePresenter {
    
    private (set) weak var view: WeekPageView?
    private (set) weak var navigator: MainNavigatorType?
    var startDate: Date
    var selectedDate: Date
    
    init(view: WeekPageView, navigator: MainNavigatorType, startDate: Date, selectedDate: Date) {
        self.navigator = navigator
        self.view = view
        self.startDate = startDate
        self.selectedDate = selectedDate
    }

    func updateView() {
        guard let view = view else { return }
        startDate = view.startDate
    }
    
    func weekDidChange() {
        updateView()
    }
    
    func createWeekViewController(for startDate: Date, selectedDate: Date) -> WeekViewController {
        return WeekViewController.create(navigator: navigator, startDate: startDate, selectedDate: selectedDate)
    }
}
