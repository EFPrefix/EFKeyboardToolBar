//
//  EFKeyboardToolBarDefaultContentView.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/11.
//

import Foundation

public protocol EFKeyboardToolBarContentViewProtocol: AnyObject {

    func reSetText(ctrl: UIView)

    func toolBarItems() -> [UIBarButtonItem]
}

public class EFKeyboardToolBarDefaultContentView: UIView, EFKeyboardToolBarContentViewProtocol {

    let EFKeyboardScrollViewWidth: CGFloat = EFKeyboardToolBar.EFKeyboardToolBarWidth - 80

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight))

        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight))
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
        scrollView.bounces = false
        self.scrollView = scrollView

        let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight))
        toolBarTextField.textAlignment = NSTextAlignment.left
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
        let finishBtnItem: UIBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(resignKeyboard))

        return [textFieldItem, finishBtnItem]
    }

    // 
    func reSetTextField(textField: UITextField) {
        let tempTextField = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        let textWidth = (tempTextField?.text ?? "").widthFor(font: toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > EFKeyboardScrollViewWidth {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
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
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
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
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: textWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - EFKeyboardScrollViewWidth, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight), animated: true)
        } else {
            toolBarTextField?.frame = CGRect(x: 0, y: 0, width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
            scrollView?.contentSize = CGSize(width: EFKeyboardScrollViewWidth, height: EFKeyboardToolBar.EFKeyboardToolBarHeight)
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
