//
//  UISearchBar+EFKeyboardToolBar.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 2018/9/10.
//

import UIKit

extension UISearchBar {

    static func enableEFKeyboardToolBar() {
        DispatchQueue.once(token: "UISearchBarloadEFKeyboardToolBar") {
            swizzleSelector(originalSelector: #selector(UISearchBar.awakeFromNib), swizzledSelector: #selector(UISearchBar.awakeFromNib_KeyboardToolBar))
            swizzleSelector(originalSelector: #selector(UISearchBar.init(frame:)), swizzledSelector: #selector(UISearchBar.initWithFrame_KeyboardToolBar(frame:)))
            swizzleSelector(originalSelector: #selector(UISearchBar.init(coder:)), swizzledSelector: #selector(UISearchBar.initWithCoder_KeyboardToolBar(coder:)))
            swizzleSelector(originalSelector: #selector(NSObject.init), swizzledSelector: #selector(UISearchBar.init_KeyboardToolBar))
        }
    }

    @objc func awakeFromNib_KeyboardToolBar() {
        addInputAccessoryView_UISearchBar()
    }

    @objc func init_KeyboardToolBar() -> UISearchBar {
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UISearchBar {
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UISearchBar {
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    public func addInputAccessoryView_UISearchBar() {
        EFKeyboardToolBar.registerKeyboardToolBarWithSearchBar(searchBar: self)
    }
}
