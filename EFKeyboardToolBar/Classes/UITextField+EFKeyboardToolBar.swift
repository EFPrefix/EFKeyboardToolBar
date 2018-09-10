//
//  UITextField+EFKeyboardToolBar.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//

import UIKit

public extension UITextField {

    static func enableEFKeyboardToolBar() {
        DispatchQueue.once(token: "UITextFieldloadEFKeyboardToolBar") {
            swizzleSelector(originalSelector: #selector(UITextField.awakeFromNib), swizzledSelector: #selector(UITextField.awakeFromNib_KeyboardToolBar))
            swizzleSelector(originalSelector: #selector(UITextField.init(frame:)), swizzledSelector: #selector(UITextField.initWithFrame_KeyboardToolBar(frame:)))
            swizzleSelector(originalSelector: #selector(UITextField.init(coder:)), swizzledSelector: #selector(UITextField.initWithCoder_KeyboardToolBar(coder:)))
            swizzleSelector(originalSelector: #selector(NSObject.init), swizzledSelector: #selector(UITextField.init_KeyboardToolBar))
        }
    }

    @objc func awakeFromNib_KeyboardToolBar() {
        print("awakeFromNib_KeyboardToolBar")
        addInputAccessoryView_UITextField()
    }

    @objc func init_KeyboardToolBar() -> UITextField {
        print("init_KeyboardToolBar")
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UITextField()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UITextField {
        print("initWithFrame_KeyboardToolBar")
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UITextField()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UITextField {
        print("initWithCoder_KeyboardToolBar")
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UITextField()
        return object
    }

    public func addInputAccessoryView_UITextField() {
        print("addInputAccessoryView_UITextField")
        EFKeyboardToolBar.registerKeyboardToolBarWithTextField(textField: self)
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
