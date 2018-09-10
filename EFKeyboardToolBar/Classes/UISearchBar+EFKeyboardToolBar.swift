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
        print("awakeFromNib_KeyboardToolBar")
        addInputAccessoryView_UISearchBar()
    }

    @objc func init_KeyboardToolBar() -> UISearchBar {
        print("init_KeyboardToolBar")
        let object = self.init_KeyboardToolBar()
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    @objc func initWithFrame_KeyboardToolBar(frame: CGRect) -> UISearchBar {
        print("initWithFrame_KeyboardToolBar")
        let object = self.initWithFrame_KeyboardToolBar(frame: frame)
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    @objc func initWithCoder_KeyboardToolBar(coder: NSCoder) -> UISearchBar {
        print("initWithCoder_KeyboardToolBar")
        let object = self.initWithCoder_KeyboardToolBar(coder: coder)
        object.addInputAccessoryView_UISearchBar()
        return object
    }

    public func addInputAccessoryView_UISearchBar() {
        print("addInputAccessoryView_UISearchBar")
        EFKeyboardToolBar.registerKeyboardToolBarWithSearchBar(searchBar: self)
    }

    class func swizzleSelector(originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(self, originalSelector) else {
            return
        }
        guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else {
            return
        }
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
