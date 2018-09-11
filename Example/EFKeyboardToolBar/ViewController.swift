//
//  ViewController.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 09/10/2018.
//  Copyright (c) 2018 EyreFree. All rights reserved.
//

import UIKit

extension UIView {

    func makeVisible() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let padding: CGFloat = 10
        let ctrlWidth = UIScreen.main.bounds.size.width - 2 * padding

        let textField = UITextField()
        textField.makeVisible()
        textField.attributedPlaceholder = NSAttributedString(
            string: "出来吧，小火龙！", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        )
        textField.frame = CGRect(x: padding, y: 60, width: ctrlWidth, height: 100)
        self.view.addSubview(textField)

        let textView = UITextView()
        textView.makeVisible()
        textView.frame = CGRect(x: padding, y: 170, width: ctrlWidth, height: 300)
        self.view.addSubview(textView)

        let searchBar = UISearchBar()
        searchBar.makeVisible()
        searchBar.placeholder = "乱序切割"
        searchBar.frame = CGRect(x: padding, y: 480, width: ctrlWidth, height: 100)
        self.view.addSubview(searchBar)
    }
}
