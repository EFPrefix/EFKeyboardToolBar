//
//  DispatchQueue+.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//

import Foundation

extension DispatchQueue {

    public class func once(token: String, block: () -> ()) {
        struct Anchors {
            static var onceTracker = [String]()
        }
        // 互斥锁加锁
        objc_sync_enter(self)
        // 作用域结束时解锁
        defer {
            objc_sync_exit(self)
        }

        if Anchors.onceTracker.contains(token) {
            return
        }
        Anchors.onceTracker.append(token)
        block()
    }
}
