//
//  DayPresenter.swift
//
//  Created by snapps
//

import Foundation

struct DayViewModel: Equatable {
    var dayHeaderViewModel: DayHeaderViewModel
    var tableviewModel: [Activity]
    var date: Date
}

class DayPresenter {
    
    private (set) weak var view: DayView?
    private (set) weak var navigator: MainNavigatorType?
    private (set) var date: Date
    
    init(view: DayView, navigator: MainNavigatorType?, date: Date) {
        self.navigator = navigator
        self.view = view
        self.date = date
    }

    var viewModel: DayViewModel {
        .init(dayHeaderViewModel: DayHeaderViewModel(dayString: getDayString(),
                                 dateString: getDateString(),
                                 isToday: date.isToday()),
            tableviewModel: buildTableViewModel(),
            date: date)
    }
    
    private func getDayString() -> String {
        return date.dayOfWeek()
    }
    
    private func getDateString() -> String {
        return date.extendedDate()
    }
    
    private func buildTableViewModel() -> [Activity] {
        return []
    }
    
    func viewWillAppear() {
        updateView()
    }

    func updateView() {
        view?.viewModel = viewModel
    }
}
