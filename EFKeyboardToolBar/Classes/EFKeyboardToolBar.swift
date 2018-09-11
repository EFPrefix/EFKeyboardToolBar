//
//  EFKeyboardToolBar.swift
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

let EFKeyboardToolBarWidth: CGFloat = UIScreen.main.bounds.size.width
let EFKeyboardToolBarHeight: CGFloat = 44
let EFKeyboardScrollViewWidth: CGFloat = UIScreen.main.bounds.size.width - 80

public class EFKeyboardToolBar: UIToolbar, UITextViewDelegate, UISearchBarDelegate {

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?
    var allRegisters: NSMutableDictionary?

    private static var _keyboardToolBar: EFKeyboardToolBar?
    private static var keyboardToolBar: EFKeyboardToolBar? {
        get {
            if let _keyboardToolBar = _keyboardToolBar {
                return _keyboardToolBar
            }
            let new_keyboardToolBar = EFKeyboardToolBar()
            _keyboardToolBar = new_keyboardToolBar
            return new_keyboardToolBar
        }
        set {
            _keyboardToolBar = newValue
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardToolBarWidth, height: EFKeyboardToolBarHeight))

        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self {
                strongSelf.barStyle = UIBarStyle.default

                let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight))
                scrollView.backgroundColor = UIColor.clear
                scrollView.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
                scrollView.bounces = false
                strongSelf.scrollView = scrollView

                let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight))
                toolBarTextField.textAlignment = NSTextAlignment.left
                toolBarTextField.isUserInteractionEnabled = false
                scrollView.addSubview(toolBarTextField)
                strongSelf.toolBarTextField = toolBarTextField

                let textFieldItem: UIBarButtonItem = UIBarButtonItem(customView: scrollView)
                let finishBtnItem: UIBarButtonItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.done, target: strongSelf, action: #selector(strongSelf.resignKeyboard))
                let buttonsArray = [textFieldItem, finishBtnItem]
                strongSelf.items = buttonsArray
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UITextField
    @objc func textFieldDidBeginWithTextField(textField: UITextField) {
        reSetTextField(textField: textField)
    }

    @objc func textFieldDidChangeWithTextField(textField: UITextField) {
        reSetTextField(textField: textField)
    }

    // UITextView
    public func textViewDidBeginEditing(_ textView: UITextView) {
        reSetTextView(textView: textView)
    }

    public func textViewDidChange(_ textView: UITextView) {
        reSetTextView(textView: textView)
    }

    // UISearchBar
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        reSetSearchBar(searchBar: searchBar)
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reSetSearchBar(searchBar: searchBar)
    }

    func reSetTextField(textField: UITextField) {
        let tempTextField = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        let textWidth = (tempTextField?.text ?? "").widthFor(font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempTextField?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.textColor = tempTextField?.textColor
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = tempTextField?.isSecureTextEntry ?? false
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = tempTextField?.placeholder
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = tempTextField?.attributedPlaceholder
    }

    func reSetTextView(textView: UITextView) {
        let tempTextView = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textView])) as? UITextView
        let textWidth = (tempTextView?.text ?? "").widthFor(font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempTextView?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.textColor = tempTextView?.textColor
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = false
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = nil
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = nil

    }

    func reSetSearchBar(searchBar: UISearchBar) {
        let tempSearchBar = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [searchBar])) as? UISearchBar
        let textWidth = (tempSearchBar?.text ?? "").widthFor(font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempSearchBar?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = false
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = nil
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = tempSearchBar?.placeholder
    }

    @objc func resignKeyboard() {
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = ""
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = ""
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

extension EFKeyboardToolBar {

    public static func enableEFKeyboardToolBar() {
        UITextField.enableEFKeyboardToolBar()
        UITextView.enableEFKeyboardToolBar()
        UISearchBar.enableEFKeyboardToolBar()
    }

    static func registerKeyboardToolBarWithTextField(textField: UITextField) {
        if EFKeyboardToolBar.keyboardToolBar?.allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if textField.inputAccessoryView != keyboardToolBar {
            textField.inputAccessoryView = keyboardToolBar
            textField.addTarget(keyboardToolBar, action: #selector(textFieldDidBeginWithTextField(textField:)), for: UIControlEvents.editingDidBegin)
            textField.addTarget(keyboardToolBar, action: #selector(textFieldDidChangeWithTextField(textField:)), for: UIControlEvents.editingChanged)
            keyboardToolBar?.allRegisters?.setValue(textField, forKey: String(format: "%p", arguments: [textField]))
        }
    }

    static func registerKeyboardToolBarWithTextView(textView: UITextView) {
        if EFKeyboardToolBar.keyboardToolBar?.allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if textView.inputAccessoryView != keyboardToolBar {
            textView.inputAccessoryView = keyboardToolBar
            textView.delegate = keyboardToolBar
            keyboardToolBar?.allRegisters?.setValue(textView, forKey: String(format: "%p", arguments: [textView]))
        }
    }

    static func registerKeyboardToolBarWithSearchBar(searchBar: UISearchBar) {
        if EFKeyboardToolBar.keyboardToolBar?.allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if searchBar.inputAccessoryView != keyboardToolBar {
            searchBar.inputAccessoryView = keyboardToolBar
            searchBar.delegate = keyboardToolBar
            keyboardToolBar?.allRegisters?.setValue(searchBar, forKey: String(format: "%p", arguments: [searchBar]))
        }
    }

    static func unregisterKeyboardToolBarWithTextField(textField: UITextField) {
        if keyboardToolBar == nil || keyboardToolBar?.allRegisters?.count == 0 {
            return
        }
        let tempTextField = keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        tempTextField?.inputAccessoryView = nil
        tempTextField?.removeTarget(keyboardToolBar, action: #selector(textFieldDidBeginWithTextField(textField:)), for: UIControlEvents.editingDidBegin)
        tempTextField?.removeTarget(keyboardToolBar, action: #selector(textFieldDidChangeWithTextField(textField:)), for: UIControlEvents.editingChanged)
        keyboardToolBar?.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [textField]))
        if keyboardToolBar?.allRegisters?.count == 0 {
            keyboardToolBar?.allRegisters = nil
            keyboardToolBar = nil
        }
    }

    static func unregisterKeyboardToolBarWithTextView(textView: UITextView) {
        if keyboardToolBar == nil || keyboardToolBar?.allRegisters?.count == 0 {
            return
        }
        let tempTextView = keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textView])) as? UITextView
        tempTextView?.inputAccessoryView = nil
        textView.delegate = nil
        keyboardToolBar?.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [textView]))
        if keyboardToolBar?.allRegisters?.count == 0 {
            keyboardToolBar?.allRegisters = nil
            keyboardToolBar = nil
        }
    }

    static func unregisterKeyboardToolBarWithSearchBar(searchBar: UISearchBar) {
        if keyboardToolBar == nil || keyboardToolBar?.allRegisters?.count == 0 {
            return
        }
        let tempSearchBar = keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [searchBar])) as? UISearchBar
        tempSearchBar?.inputAccessoryView = nil
        searchBar.delegate = nil
        keyboardToolBar?.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [searchBar]))
        if keyboardToolBar?.allRegisters?.count == 0 {
            keyboardToolBar?.allRegisters = nil
            keyboardToolBar = nil
        }
    }
}
