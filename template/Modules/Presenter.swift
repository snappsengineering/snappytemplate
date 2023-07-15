//
//  Presenter.swift
//
//  Created by snapps
//

import Foundation

protocol Presenter: AnyObject {
    func load()
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

// Default implementation for all
extension Presenter {
    func load() {}
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
