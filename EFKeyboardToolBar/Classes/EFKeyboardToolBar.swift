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

    public static private(set) var config: EFKeyboardToolBarConfig = EFKeyboardToolBarConfig() {
        didSet {
            EFKeyboardToolBar.keyboardToolBar = nil
        }
    }

    public static var allRegisters: NSMutableDictionary?

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
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardToolBar.config.toolBarWidth, height: EFKeyboardToolBar.config.toolBarHeight))
        self.barStyle = EFKeyboardToolBar.config.toolBarStyle

        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self {
                if nil == EFKeyboardToolBar.config.toolBarContentView {
                    EFKeyboardToolBar.config.toolBarContentView = EFKeyboardToolBarDefaultContentView()
                }
                strongSelf.items = EFKeyboardToolBar.config.toolBarContentView?.toolBarItems()
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static func setConfig(config: EFKeyboardToolBarConfig) {
        self.config = config
    }

    // UITextField
    @objc func textFieldDidBeginWithTextField(textField: UITextField) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: textField)
    }

    @objc func textFieldDidChangeWithTextField(textField: UITextField) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: textField)
    }

    // UITextView
    public func textViewDidBeginEditing(_ textView: UITextView) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: textView)
    }

    public func textViewDidChange(_ textView: UITextView) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: textView)
    }

    // UISearchBar
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: searchBar)
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        EFKeyboardToolBar.config.toolBarContentView?.reSetText(ctrl: searchBar)
    }
}

extension EFKeyboardToolBar {

    public static func enableEFKeyboardToolBar() {
        UITextField.enableEFKeyboardToolBar()
        UITextView.enableEFKeyboardToolBar()
        UISearchBar.enableEFKeyboardToolBar()
    }

    public static func registerKeyboardToolBarWithTextField(textField: UITextField) {
        if EFKeyboardToolBar.allRegisters == nil {
            EFKeyboardToolBar.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if textField.inputAccessoryView != keyboardToolBar {
            textField.inputAccessoryView = keyboardToolBar
            textField.addTarget(keyboardToolBar, action: #selector(textFieldDidBeginWithTextField(textField:)), for: UIControlEvents.editingDidBegin)
            textField.addTarget(keyboardToolBar, action: #selector(textFieldDidChangeWithTextField(textField:)), for: UIControlEvents.editingChanged)
            EFKeyboardToolBar.allRegisters?.setValue(textField, forKey: String(format: "%p", arguments: [textField]))
        }
    }

    public static func registerKeyboardToolBarWithTextView(textView: UITextView) {
        if EFKeyboardToolBar.allRegisters == nil {
            EFKeyboardToolBar.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if textView.inputAccessoryView != keyboardToolBar {
            textView.inputAccessoryView = keyboardToolBar
            textView.delegate = keyboardToolBar
            EFKeyboardToolBar.allRegisters?.setValue(textView, forKey: String(format: "%p", arguments: [textView]))
        }
    }

    public static func registerKeyboardToolBarWithSearchBar(searchBar: UISearchBar) {
        if EFKeyboardToolBar.allRegisters == nil {
            EFKeyboardToolBar.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        if searchBar.inputAccessoryView != keyboardToolBar {
            searchBar.inputAccessoryView = keyboardToolBar
            searchBar.delegate = keyboardToolBar
            EFKeyboardToolBar.allRegisters?.setValue(searchBar, forKey: String(format: "%p", arguments: [searchBar]))
        }
    }

    public static func unregisterKeyboardToolBarWithTextField(textField: UITextField) {
        if keyboardToolBar == nil || EFKeyboardToolBar.allRegisters?.count == 0 {
            return
        }
        let tempTextField = EFKeyboardToolBar.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        tempTextField?.inputAccessoryView = nil
        tempTextField?.removeTarget(keyboardToolBar, action: #selector(textFieldDidBeginWithTextField(textField:)), for: UIControlEvents.editingDidBegin)
        tempTextField?.removeTarget(keyboardToolBar, action: #selector(textFieldDidChangeWithTextField(textField:)), for: UIControlEvents.editingChanged)
        EFKeyboardToolBar.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [textField]))
        if EFKeyboardToolBar.allRegisters?.count == 0 {
            EFKeyboardToolBar.allRegisters = nil
            keyboardToolBar = nil
        }
    }

    public static func unregisterKeyboardToolBarWithTextView(textView: UITextView) {
        if keyboardToolBar == nil || EFKeyboardToolBar.allRegisters?.count == 0 {
            return
        }
        let tempTextView = EFKeyboardToolBar.allRegisters?.object(forKey: String(format: "%p", arguments: [textView])) as? UITextView
        tempTextView?.inputAccessoryView = nil
        textView.delegate = nil
        EFKeyboardToolBar.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [textView]))
        if EFKeyboardToolBar.allRegisters?.count == 0 {
            EFKeyboardToolBar.allRegisters = nil
            keyboardToolBar = nil
        }
    }

    public static func unregisterKeyboardToolBarWithSearchBar(searchBar: UISearchBar) {
        if keyboardToolBar == nil || EFKeyboardToolBar.allRegisters?.count == 0 {
            return
        }
        let tempSearchBar = EFKeyboardToolBar.allRegisters?.object(forKey: String(format: "%p", arguments: [searchBar])) as? UISearchBar
        tempSearchBar?.inputAccessoryView = nil
        searchBar.delegate = nil
        EFKeyboardToolBar.allRegisters?.removeObject(forKey: String(format: "%p", arguments: [searchBar]))
        if EFKeyboardToolBar.allRegisters?.count == 0 {
            EFKeyboardToolBar.allRegisters = nil
            keyboardToolBar = nil
        }
    }
}
