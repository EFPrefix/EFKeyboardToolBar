//
//  ViewController.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 09/10/2018.
//  Copyright (c) 2018 EyreFree. All rights reserved.
//

import UIKit
import EFKeyboardToolBar

extension UIView {

    func makeVisible() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4
    }
}

class ViewController: UIViewController {

    let buttonDefault = UIButton(type: .system)
    let buttonCustom = UIButton(type: .system)
    var textField: UITextField?
    var textView: UITextView?
    var searchBar: UISearchBar?

    let statusBarHeight: CGFloat = 44
    let padding: CGFloat = 10
    let ctrlWidth = UIScreen.main.bounds.size.width - 20

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        buttonDefault.makeVisible()
        buttonDefault.setTitle("默认样式", for: .normal)
        buttonDefault.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        buttonDefault.frame = CGRect(x: padding, y: statusBarHeight + padding, width: (ctrlWidth - 10) / 2, height: 64)
        self.view.addSubview(buttonDefault)

        buttonCustom.makeVisible()
        buttonCustom.setTitle("自定义样式", for: .normal)
        buttonCustom.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        buttonCustom.frame = CGRect(x: buttonDefault.frame.maxX + padding, y: statusBarHeight + padding, width: (ctrlWidth - 10) / 2, height: 64)
        self.view.addSubview(buttonCustom)

        addInputCtrls()
    }

    func addInputCtrls() {
        let textField = UITextField()
        textField.makeVisible()
        textField.attributedPlaceholder = NSAttributedString(
            string: "出来吧，小火龙！", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        )
        textField.frame = CGRect(x: padding, y: buttonCustom.frame.maxY + padding, width: ctrlWidth, height: 100)
        self.view.addSubview(textField)
        self.textField = textField

        let textView = UITextView()
        textView.makeVisible()
        textView.frame = CGRect(x: padding, y: textField.frame.maxY + padding, width: ctrlWidth, height: 200)
        self.view.addSubview(textView)
        self.textView = textView

        let searchBar = UISearchBar()
        searchBar.makeVisible()
        searchBar.placeholder = "发表你的机智评论吧"
        searchBar.frame = CGRect(x: padding, y: textView.frame.maxY + padding, width: ctrlWidth, height: 100)
        self.view.addSubview(searchBar)
        self.searchBar = searchBar
    }

    func removeInputCtrls() {
        for ctrl in [textField, textView, searchBar] {
            ctrl?.removeFromSuperview()
        }
    }

    @objc func buttonClicked(button: UIButton) {
        switch button.title(for: .normal) ?? "" {
        case "自定义样式":
            EFKeyboardToolBar.EFKeyboardToolBarHeight = 60
            EFKeyboardToolBar.toolBarContentView = EFKeyboardToolBarCustomContentView()
            EFKeyboardToolBar.keyboardToolBar = nil
            EFKeyboardToolBar.keyboardToolBar?.backgroundColor = UIColor.white
            break
        default:
            EFKeyboardToolBar.EFKeyboardToolBarHeight = 44
            EFKeyboardToolBar.toolBarContentView = EFKeyboardToolBarDefaultContentView()
            EFKeyboardToolBar.keyboardToolBar = nil
            EFKeyboardToolBar.keyboardToolBar?.backgroundColor = UIColor.white
            break
        }
        removeInputCtrls()
        addInputCtrls()
    }
}
