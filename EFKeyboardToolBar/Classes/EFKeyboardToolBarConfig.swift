//
//  EFKeyboardToolBarConfig.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/11.
//

import Foundation

public class EFKeyboardToolBarConfig: NSObject {

    public var toolBarStyle: UIBarStyle = .default

    public var toolBarWidth: CGFloat = UIScreen.main.bounds.size.width
    public var toolBarHeight: CGFloat = 44

    public var toolBarContentView: EFKeyboardToolBarContentViewProtocol?
}
