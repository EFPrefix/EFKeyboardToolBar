
import UIKit

let KeyboardToolBarWidth: CGFloat = UIScreen.main.bounds.size.width
let KeyboardToolBarHeight: CGFloat = 44
let KeyboardScrollViewWidth: CGFloat = KeyboardToolBarWidth - 80

public class EFKeyboardToolBar: UIToolbar, UITextViewDelegate, UISearchBarDelegate {

    var toolBarTextField: UITextField?
    var scrollView: UIScrollView?
    var allRegisters: NSMutableDictionary?

    static var keyboardToolBar: EFKeyboardToolBar? = nil

    public static func enableEFKeyboardToolBar() {
        UITextField.enableEFKeyboardToolBar()
        UITextView.enableEFKeyboardToolBar()
        UISearchBar.enableEFKeyboardToolBar()
    }

    static func registerKeyboardToolBarWithTextField(textField: UITextField) {
        if EFKeyboardToolBar.shareKeyboardToolBar().allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        textField.inputAccessoryView = keyboardToolBar
        textField.addTarget(keyboardToolBar, action: #selector(textFieldDidBeginWithTextField(textField:)), for: UIControlEvents.editingDidBegin)
        textField.addTarget(keyboardToolBar, action: #selector(textFieldDidChangeWithTextField(textField:)), for: UIControlEvents.editingChanged)
        keyboardToolBar?.allRegisters?.setValue(textField, forKey: String(format: "%p", arguments: [textField]))
    }

    static func registerKeyboardToolBarWithTextView(textView: UITextView) {
        if EFKeyboardToolBar.shareKeyboardToolBar().allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        textView.inputAccessoryView = keyboardToolBar
        textView.delegate = keyboardToolBar
        keyboardToolBar?.allRegisters?.setValue(textView, forKey: String(format: "%p", arguments: [textView]))
    }

    static func registerKeyboardToolBarWithSearchBar(searchBar: UISearchBar) {
        if EFKeyboardToolBar.shareKeyboardToolBar().allRegisters == nil {
            keyboardToolBar?.allRegisters = NSMutableDictionary.init(capacity: 10)
        }
        searchBar.inputAccessoryView = keyboardToolBar
        searchBar.delegate = keyboardToolBar
        keyboardToolBar?.allRegisters?.setValue(searchBar, forKey: String(format: "%p", arguments: [searchBar]))
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

    static func shareKeyboardToolBar() -> EFKeyboardToolBar {
        if keyboardToolBar == nil {
            keyboardToolBar = EFKeyboardToolBar.init(frame: CGRect(x: 0, y: 0, width: KeyboardToolBarWidth, height: KeyboardToolBarHeight))
            keyboardToolBar?.barStyle = UIBarStyle.default

            let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight))
            scrollView.backgroundColor = UIColor.clear
            scrollView.contentSize = CGSize(width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
            scrollView.bounces = false
            keyboardToolBar?.scrollView = scrollView

            let toolBarTextField = UITextField.init(frame: CGRect(x: 0, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight))
            toolBarTextField.textAlignment = NSTextAlignment.left
            toolBarTextField.isUserInteractionEnabled = false
            scrollView.addSubview(toolBarTextField)
            keyboardToolBar?.toolBarTextField = toolBarTextField

            let textFieldItem: UIBarButtonItem = UIBarButtonItem(customView: scrollView)
            let finishBtnItem: UIBarButtonItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.done, target: keyboardToolBar, action: #selector(resignKeyboard))
            let buttonsArray = [textFieldItem, finishBtnItem]
            keyboardToolBar?.items = buttonsArray
        }
        return keyboardToolBar!
    }

    // UITextField
    @objc func textFieldDidBeginWithTextField(textField: UITextField) {
        reSetTextField(textField: textField)
    }

    @objc func textFieldDidChangeWithTextField(textField: UITextField) {
        reSetTextField(textField: textField)
    }

    // UITextView
    public func textViewDidBeginEditing(_ textView: UITextView) {
        reSetTextView(textView: textView)
    }

    public func textViewDidChange(_ textView: UITextView) {
        reSetTextView(textView: textView)
    }

    // UISearchBar
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        reSetSearchBar(searchBar: searchBar)
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reSetSearchBar(searchBar: searchBar)
    }

    func reSetTextField(textField: UITextField) {
        let tempTextField = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textField])) as? UITextField
        let textWidth = EFKeyboardToolBar.widthForString(str: tempTextField?.text ?? "", font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > KeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: KeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - KeyboardScrollViewWidth, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempTextField?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.textColor = tempTextField?.textColor
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = tempTextField?.isSecureTextEntry ?? false
        if let placeholder = tempTextField?.placeholder {
            let attribute = textField.attributedPlaceholder
            let dictionary = attribute?.attributes(at: 0, effectiveRange: nil)
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedStringKey.foregroundColor : dictionary?[NSAttributedStringKey.foregroundColor] ?? UIColor.black]
            )
        }
    }

    func reSetTextView(textView: UITextView) {
        let tempTextView = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [textView])) as? UITextView
        let textWidth = EFKeyboardToolBar.widthForString(str: tempTextView?.text ?? "", font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > KeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: KeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - KeyboardScrollViewWidth, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempTextView?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.textColor = tempTextView?.textColor
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = false
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = nil
    }

    func reSetSearchBar(searchBar: UISearchBar) {
        let tempSearchBar = EFKeyboardToolBar.keyboardToolBar?.allRegisters?.object(forKey: String(format: "%p", arguments: [searchBar])) as? UISearchBar
        let textWidth = EFKeyboardToolBar.widthForString(str: tempSearchBar?.text ?? "", font: EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.font ?? UIFont.systemFont(ofSize: 14))
        if textWidth > KeyboardScrollViewWidth {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: textWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: textWidth, height: KeyboardToolBarHeight)
            self.scrollView?.scrollRectToVisible(CGRect(x: textWidth - KeyboardScrollViewWidth, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight), animated: true)
        } else {
            EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.frame = CGRect(x: 0, y: 0, width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
            EFKeyboardToolBar.keyboardToolBar?.scrollView?.contentSize = CGSize(width: KeyboardScrollViewWidth, height: KeyboardToolBarHeight)
        }
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = tempSearchBar?.text
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.isSecureTextEntry = false
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.attributedPlaceholder = nil
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = tempSearchBar?.placeholder
    }

    @objc func resignKeyboard() {
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.text = ""
        EFKeyboardToolBar.keyboardToolBar?.toolBarTextField?.placeholder = ""
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    static func widthForString(str: String, font: UIFont) -> CGFloat {
        let attribute = [NSAttributedStringKey.font: font]
        let size = (str as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading],
            attributes: attribute,
            context: nil
        )
        return size.width
    }
}
