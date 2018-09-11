//
//  EFKeyboardToolBarCustomContentView.swift
//  EFKeyboardToolBar_Example
//
//  Created by EyreFree on 2018/9/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import EFKeyboardToolBar

extension UIColor {

    // 用十六进制数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

public class EFKeyboardToolBarCustomContentView: UIView, EFKeyboardToolBarContentViewProtocol {

    let EFKeyboardScrollViewWidth: CGFloat = EFKeyboardToolBar.EFKeyboardToolBarWidth - 80

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight))

        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 12, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24))
        scrollView.backgroundColor = UIColor(valueRGB: 0xf0f0f0)
        scrollView.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
        scrollView.bounces = false
        scrollView.layer.cornerRadius = 8
        scrollView.clipsToBounds = true
        self.scrollView = scrollView

        let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24))
        toolBarTextField.textAlignment = NSTextAlignment.left
        toolBarTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        toolBarTextField.isUserInteractionEnabled = false
        scrollView.addSubview(toolBarTextField)
        self.toolBarTextField = toolBarTextField

        self.addSubview(scrollView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- EFKeyboardToolBarProtocol
    public func reSetText(ctrl: UIView) {
        if let textField = ctrl as? UITextField {
            reSetTextField(textField: textField)
        } else if let textView = ctrl as? UITextView {
            reSetTextView(textView: textView)
        } else if let searchBar = ctrl as? UISearchBar {
            reSetSearchBar(searchBar: searchBar)
        }
    }

    public func toolBarItems() -> [UIBarButtonItem] {
        let textFieldItem: UIBarButtonItem = UIBarButtonItem(customView: self)

        let xxx = UIButton(type: .system)
        xxx.setTitle("发布", for: .normal)
        xxx.setTitleColor(UIColor(valueRGB: 0xb3c0b4), for: .normal)
        xxx.addTarget(self, action: #selector(resignKeyboard), for: .touchUpInside)
        let finishBtnItem: UIBarButtonItem = UIBarButtonItem(customView: xxx)

        return [textFieldItem, finishBtnItem]
    }

    //
    func reSetTextField(textField: UITextField) {
        let tempTextField = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        let textWidth = (tempTextField?.text ?? "").widthFor(font: toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
        }
        toolBarTextField?.text = tempTextField?.text
        toolBarTextField?.textColor = tempTextField?.textColor
        toolBarTextField?.isSecureTextEntry = tempTextField?.isSecureTextEntry ?? false
        toolBarTextField?.placeholder = tempTextField?.placeholder
        toolBarTextField?.attributedPlaceholder = tempTextField?.attributedPlaceholder
    }

    func reSetTextView(textView: UITextView) {
        let tempTextView = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textView])) as? UITextView
        let textWidth = (tempTextView?.text ?? "").widthFor(font: toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
        }
        toolBarTextField?.text = tempTextView?.text
        toolBarTextField?.textColor = tempTextView?.textColor
        toolBarTextField?.isSecureTextEntry = false
        toolBarTextField?.placeholder = nil
        toolBarTextField?.attributedPlaceholder = nil

    }

    func reSetSearchBar(searchBar: UISearchBar) {
        let tempSearchBar = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [searchBar])) as? UISearchBar
        let textWidth = (tempSearchBar?.text ?? "").widthFor(font: toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight - 24)
        }
        toolBarTextField?.text = tempSearchBar?.text
        toolBarTextField?.isSecureTextEntry = false
        toolBarTextField?.attributedPlaceholder = nil
        toolBarTextField?.placeholder = tempSearchBar?.placeholder
    }

    @objc func resignKeyboard() {
        toolBarTextField?.text = ""
        toolBarTextField?.placeholder = ""
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
