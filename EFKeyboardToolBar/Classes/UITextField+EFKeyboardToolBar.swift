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
        addInputAccessoryView_UITextField()
    }

    @objc func init_KeyboardToolBar() -> UITextField {
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UITextField()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UITextField {
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UITextField()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UITextField {
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UITextField()
        return object
    }

    public func addInputAccessoryView_UITextField() {
        EFKeyboardToolBar.registerKeyboardToolBarWithTextField(textField: self)
    }
}
