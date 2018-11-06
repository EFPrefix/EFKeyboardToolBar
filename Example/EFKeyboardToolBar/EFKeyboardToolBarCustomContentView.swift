//
//  EFKeyboardToolBarCustomContentView.swift
//  EFKeyboardToolBar_Example
//
//  Created by EyreFree on 2018/9/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import EFKeyboardToolBar

public class EFKeyboardToolBarCustomContentView: UIView, EFKeyboardToolBarContentViewProtocol {

    let toolBarHeight: CGFloat = 60
    let toolBarWidth: CGFloat = UIScreen.main.bounds.size.width

    let scrollViewWidth: CGFloat = UIScreen.main.bounds.size.width - 80
    let scrollViewHeight: CGFloat = 60 - 24

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: toolBarHeight))

        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 12, width: scrollViewWidth, height: scrollViewHeight))
        scrollView.backgroundColor = UIColor(valueRGB: 0xf0f0f0)
        scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)
        scrollView.bounces = false
        scrollView.layer.cornerRadius = 8
        scrollView.clipsToBounds = true
        self.scrollView = scrollView

        let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        toolBarTextField.textAlignment = NSTextAlignment.left
        toolBarTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
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
        let maxScrollViewWidth: CGFloat = max(textWidth, scrollViewWidth)
        if textWidth > scrollViewWidth {
            scrollView?.scrollRectToVisible(
                CGRect(x: textWidth - scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight),
                animated: true
            )
        }
        toolBarTextField?.frame = CGRect(x: 0, y: 0, width: maxScrollViewWidth, height: scrollViewHeight)
        scrollView?.contentSize = CGSize(width: maxScrollViewWidth, height: scrollViewHeight)
        toolBarTextField?.text = attributes.text
        toolBarTextField?.textColor = attributes.textColor
        toolBarTextField?.isSecureTextEntry = attributes.isSecure
        toolBarTextField?.placeholder = attributes.placeholder
        toolBarTextField?.attributedPlaceholder = attributes.attributedPlaceholder
    }

    public func toolBarItems() -> [UIBarButtonItem] {
        let textFieldItem: UIBarButtonItem = UIBarButtonItem(customView: self)

        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("发布", for: .normal)
        confirmButton.setTitleColor(UIColor(valueRGB: 0xb3c0b4), for: .normal)
        confirmButton.addTarget(self, action: #selector(resignKeyboard), for: .touchUpInside)
        let finishBtnItem: UIBarButtonItem = UIBarButtonItem(customView: confirmButton)

        return [textFieldItem, finishBtnItem]
    }
}
