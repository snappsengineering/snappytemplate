//
//  UIControl+Events.swift
//
//  Created by snapps
//

import UIKit

private class EventHandler {
    let handler: (UIControl, UIEvent) -> Void
    let oneshot: Bool

    init(_ handler: @escaping (UIControl, UIEvent) -> Void, oneshot: Bool) {
        self.handler = handler
        self.oneshot = oneshot
    }

    @objc func invoke(_ sender: UIControl, event: UIEvent) {
        handler(sender, event)
        if oneshot {
            sender.off(Unmanaged.passUnretained(self).toOpaque())
        }
    }
}

extension UIControl {
    /**
     This extension is used to conveniently add handlers to controls without delegation.

     For example see Login's Username TextField:

     usernameTextField.on([.editingDidBegin, .editingChanged, .editingDidEnd]) { [weak self] in
         self?.unobscuredUsername = self?.usernameTextField.text
         self?.presenter?.validateUpdatedUsername(self?.unobscuredUsername)
     }

     See: http://codereview.stackexchange.com/questions/73364/closure-as-uicontrolevents-handler

     */
    typealias EventHandlerId = UnsafeMutableRawPointer

    @discardableResult func on<T: UIControl>(_ events: UIControl.Event, _ callback: @escaping (T, UIEvent) -> Void) -> EventHandlerId {
        // swiftlint:disable force_cast
        _on(events, EventHandler({ callback($0 as! T, $1) }, oneshot: false))
    }

    @discardableResult func once<T: UIControl>(_ events: UIControl.Event, _ callback: @escaping (T, UIEvent) -> Void) -> EventHandlerId {
        // swiftlint:disable force_cast
        _on(events, EventHandler({ callback($0 as! T, $1) }, oneshot: true))
    }

    @discardableResult func on(_ events: UIControl.Event, _ callback: @escaping () -> Void) -> EventHandlerId {
        _on(events, EventHandler({ _, _ in callback() }, oneshot: false))
    }

    @discardableResult func once(_ events: UIControl.Event, _ callback: @escaping () -> Void) -> EventHandlerId {
        _on(events, EventHandler({ _, _ in callback() }, oneshot: true))
    }

    func off(_ identifier: EventHandlerId) {
        if let handler = objc_getAssociatedObject(self, identifier) as? EventHandler {
            removeTarget(handler, action: nil, for: .allEvents)
            objc_setAssociatedObject(self, identifier, nil, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    private func _on(_ events: UIControl.Event, _ handler: EventHandler) -> EventHandlerId {
        let identifier = Unmanaged.passUnretained(handler).toOpaque()
        addTarget(handler, action: #selector(handler.invoke(_:event:)), for: events)
        objc_setAssociatedObject(self, identifier, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return identifier
    }
}

extension UIBarButtonItem {
    typealias EventHandlerId = UnsafeMutableRawPointer

    @discardableResult
    func on<T: UIControl>(_ events: UIControl.Event, _ callback: @escaping (T, UIEvent) -> Void) -> EventHandlerId {
        // swiftlint:disable force_cast
        _on(events, EventHandler({ callback($0 as! T, $1) }, oneshot: false))
    }

    @discardableResult
    func once<T: UIControl>(_ events: UIControl.Event, _ callback: @escaping (T, UIEvent) -> Void) -> EventHandlerId {
        // swiftlint:disable force_cast
        _on(events, EventHandler({ callback($0 as! T, $1) }, oneshot: true))
    }

    @discardableResult
    func on(_ events: UIControl.Event, _ callback: @escaping () -> Void) -> EventHandlerId {
        _on(events, EventHandler({ _, _ in callback() }, oneshot: false))
    }

    @discardableResult
    func once(_ events: UIControl.Event, _ callback: @escaping () -> Void) -> EventHandlerId {
        _on(events, EventHandler({ _, _ in callback() }, oneshot: true))
    }

    func off(_ identifier: EventHandlerId) {
        target = nil
        action = nil
        objc_setAssociatedObject(self, identifier, nil, .OBJC_ASSOCIATION_ASSIGN)
    }

    private func _on(_ events: UIControl.Event, _ handler: EventHandler) -> EventHandlerId {
        let identifier = Unmanaged.passUnretained(handler).toOpaque()
        target = handler
        action = #selector(handler.invoke(_:event:))
        objc_setAssociatedObject(self, identifier, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return identifier
    }
}
