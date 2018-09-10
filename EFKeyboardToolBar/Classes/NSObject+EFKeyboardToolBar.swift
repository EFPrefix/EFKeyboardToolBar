//
//  NSObject+.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//

import Foundation

extension NSObject {

    public static func swizzleSelector(originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(self, originalSelector) else {
            return
        }
        guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else {
            return
        }
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
