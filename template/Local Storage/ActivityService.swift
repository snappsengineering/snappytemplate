//
//  ActivityService.swift
//
//  Created by snapps
//

import Foundation
import UIKit

struct ActivityService<T: Storable> {
    
    var activities: [Activity] {
        get {
            LocalStorageService<T>.fetch(element: [Activity]())
        }
        set {
            LocalStorageService<T>.store(element: newValue)
        }
    }
    
    func fetchActivities(for date: Date) -> [Activity] {
        return activities.filter({ $0.date == date })
    }
    
    func fetchAllActivities() -> [Activity] {
        return activities
    }
    
    mutating func save(activity: Activity) {
        delete(activity: activity)
        activities.append(activity)
    }
    
    mutating func delete(activity: Activity) {
        activities.removeAll(where: { $0 == activity })
    }
}

extension Array: Storable where Element == Activity {}
