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
        addInputAccessoryView_UITextView()
    }

    @objc func init_KeyboardToolBar() -> UITextView {
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UITextView()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UITextView {
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UITextView()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UITextView {
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UITextView()
        return object
    }

    public func addInputAccessoryView_UITextView() {
        EFKeyboardToolBar.registerKeyboardToolBarWithTextView(textView: self)
    }
}
