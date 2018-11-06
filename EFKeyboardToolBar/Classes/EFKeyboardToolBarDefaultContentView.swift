//
//  EFKeyboardToolBarDefaultContentView.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/11.
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

import Foundation

public protocol EFKeyboardToolBarContentViewProtocol: AnyObject {

    func reSetText(ctrl: UIView)

    func toolBarItems() -> [UIBarButtonItem]
}

public class EFKeyboardToolBarDefaultContentView: UIView, EFKeyboardToolBarContentViewProtocol {

    let EFKeyboardScrollViewWidth: CGFloat = EFKeyboardToolBar.config.toolBarWidth - 80

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight))

        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight))
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight)
        scrollView.bounces = false
        self.scrollView = scrollView

        let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight))
        toolBarTextField.textAlignment = NSTextAlignment.left
        toolBarTextField.isUserInteractionEnabled = false
        scrollView.addSubview(toolBarTextField)
        self.toolBarTextField = toolBarTextField

        self.addSubview(scrollView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func resignKeyboard() {
        toolBarTextField?.text = nil
        toolBarTextField?.placeholder = nil
        toolBarTextField?.attributedPlaceholder = nil
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    // MARK:- EFKeyboardToolBarProtocol
    public func reSetText(ctrl: UIView) {
        let attributes: (text: String?, textColor: UIColor?, isSecure: Bool, placeholder: String?, attributedPlaceholder: NSAttributedString?) = {
            let ctrl = EFKeyboardToolBar.allRegisters?.object(forKey: String(format: "%p", arguments: [ctrl]))
            if let textField = ctrl as? UITextField {
                return (textField.text, textField.textColor, textField.isSecureTextEntry, textField.placeholder, textField.attributedPlaceholder)
            } else if let textView = ctrl as? UITextView {
                return (textView.text, textView.textColor, false, nil, nil)
            } else if let searchBar = ctrl as? UISearchBar {
                return (searchBar.text, nil, false, searchBar.placeholder, nil)
            }
            return (nil, nil, false, nil, nil)
        }()

        let textWidth: CGFloat = attributes.text?.widthFor(font: toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14)) ?? 0
        let maxScrollViewWidth: CGFloat = max(textWidth, EFKeyboardScrollViewWidth)
        if textWidth > EFKeyboardScrollViewWidth {
            scrollView?.scrollRectToVisible(
                CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight),
                animated: true
            )
        }
        toolBarTextField?.frame = CGRect(x: 0, y: 0, width: maxScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight)
        scrollView?.contentSize = CGSize(width: maxScrollViewWidth, height: EFKeyboardToolBar.config.toolBarHeight)
        toolBarTextField?.text = attributes.text
        toolBarTextField?.textColor = attributes.textColor
        toolBarTextField?.isSecureTextEntry = attributes.isSecure
        toolBarTextField?.placeholder = attributes.placeholder
        toolBarTextField?.attributedPlaceholder = attributes.attributedPlaceholder
    }

    public func toolBarItems() -> [UIBarButtonItem] {
        let textFieldItem: UIBarButtonItem = UIBarButtonItem(customView: self)
        let finishBtnItem: UIBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItem.Style.done, target: self, action: #selector(resignKeyboard))

        return [textFieldItem, finishBtnItem]
    }
}
