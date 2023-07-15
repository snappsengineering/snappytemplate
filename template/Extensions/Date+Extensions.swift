//
//  Date+Extensions.swift
//
//  Created by snapps
//

import Foundation

extension Date {
    
    static var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        return calendar
    }
    
    static var today: Date {
        Date().startOfDay
    }
    
    var startOfDay: Date {
        Date.calendar.startOfDay(for: self)
    }
    
    var getMonday: Date {
        var comps = Date.calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        comps.weekday = 2 // Monday
        let mondayInWeek = Date.calendar.date(from: comps)!
        return mondayInWeek
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func shortDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayOfMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self).capitalized
    }
    
    func weekDayString() -> String {
        shortDayOfWeek() + "\n" + dayOfMonth()
    }
    
    func extendedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func isToday() -> Bool {
        return Date.calendar.isDateInToday(self)
    }
    
    func isYesterday() -> Bool {
        return Date.calendar.isDateInYesterday(self)
    }
    
    func isTomorrow() -> Bool {
        return Date.calendar.isDateInTomorrow(self)
    }
    
    func isPast() -> Bool {
        return self < Date.today
    }
    
    func isFuture() -> Bool {
        return self > Date.today
    }
    
    func toString(dateFormat format: String = "dd-MMM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Date.calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func hasSame(date: Date) -> Bool {
        return self == date
    }
}
