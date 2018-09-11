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

public class EFKeyboardToolBar: UIToolbar, UITextViewDelegate, UISearchBarDelegate {

    public static var EFKeyboardToolBarWidth: CGFloat = UIScreen.main.bounds.size.width
    public static var EFKeyboardToolBarHeight: CGFloat = 44

    public static var toolBarContentView: EFKeyboardToolBarContentViewProtocol?

    public var allRegisters: NSMutableDictionary?

    private static var _keyboardToolBar: EFKeyboardToolBar?
    public static var keyboardToolBar: EFKeyboardToolBar? {
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
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardToolBar.EFKeyboardToolBarWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight))
        self.barStyle = UIBarStyle.default

        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self {
                if nil == EFKeyboardToolBar.toolBarContentView {
                    EFKeyboardToolBar.toolBarContentView = EFKeyboardToolBarDefaultContentView()
                }
                strongSelf.items = EFKeyboardToolBar.toolBarContentView?.toolBarItems()
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UITextField
    @objc func textFieldDidBeginWithTextField(textField: UITextField) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: textField)
    }

    @objc func textFieldDidChangeWithTextField(textField: UITextField) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: textField)
    }

    // UITextView
    public func textViewDidBeginEditing(_ textView: UITextView) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: textView)
    }

    public func textViewDidChange(_ textView: UITextView) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: textView)
    }

    // UISearchBar
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: searchBar)
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        EFKeyboardToolBar.toolBarContentView?.reSetText(ctrl: searchBar)
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
