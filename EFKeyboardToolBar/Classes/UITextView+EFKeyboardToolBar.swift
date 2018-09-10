//
//  UITextView+EFKeyboardToolBar.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//

import UIKit

extension UITextView {

    static func enableEFKeyboardToolBar() {
        DispatchQueue.once(token: "UITextViewloadEFKeyboardToolBar") {
            swizzleSelector(originalSelector: #selector(UITextView.awakeFromNib), swizzledSelector: #selector(UITextView.awakeFromNib_KeyboardToolBar))
            swizzleSelector(originalSelector: #selector(UITextView.init(frame:)), swizzledSelector: #selector(UITextView.initWithFrame_KeyboardToolBar(frame:)))
            swizzleSelector(originalSelector: #selector(UITextView.init(coder:)), swizzledSelector: #selector(UITextView.initWithCoder_KeyboardToolBar(coder:)))
            swizzleSelector(originalSelector: #selector(NSObject.init), swizzledSelector: #selector(UITextView.init_KeyboardToolBar))
        }
    }

    @objc func awakeFromNib_KeyboardToolBar() {
        print("awakeFromNib_KeyboardToolBar")
        addInputAccessoryView_UITextView()
    }

    @objc func init_KeyboardToolBar() -> UITextView {
        print("init_KeyboardToolBar")
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UITextView()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UITextView {
        print("initWithFrame_KeyboardToolBar")
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UITextView()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UITextView {
        print("initWithCoder_KeyboardToolBar")
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UITextView()
        return object
    }

    public func addInputAccessoryView_UITextView() {
        print("addInputAccessoryView_UITextView")
        EFKeyboardToolBar.registerKeyboardToolBarWithTextView(textView: self)
    }

    class func swizzleSelector(originalSelector: Selector, swizzledSelector: Selector) {
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
