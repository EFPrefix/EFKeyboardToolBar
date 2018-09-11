//
//  UITextField+EFKeyboardToolBar.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//
//  Copyright (c) 2018 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
