# EFKeyboardToolBar

[![CI Status](https://img.shields.io/travis/EFPrefix/EFKeyboardToolBar.svg?style=flat)](https://travis-ci.org/EFPrefix/EFKeyboardToolBar)
[![Version](https://img.shields.io/cocoapods/v/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)
[![License](https://img.shields.io/cocoapods/l/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)
[![Platform](https://img.shields.io/cocoapods/p/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)

A keyboard toolBar in Swift, inspired by [KeyboardToolBar](https://github.com/Jiar/KeyboardToolBar).

> [中文介绍](https://github.com/EFPrefix/EFKeyboardToolBar/blob/master/README_CN.md)

## Preview

| Default | Custom |
|:---------------------:|:---------------------:|
![](https://github.com/EFPrefix/EFKeyboardToolBar/blob/master/Assets/default.png?raw=true)|![](https://github.com/EFPrefix/EFKeyboardToolBar/blob/master/Assets/custom.png?raw=true)   

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

| Version | Needs                                 |
|:--------|:--------------------------------------|
| 1.x     | Xcode 9.0+<br>Swift 4.0+<br>iOS 8.0+  |
| 5.x     | Xcode 10.2+<br>Swift 5.0+<br>iOS 8.0+ |

## Installation

EFKeyboardToolBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EFKeyboardToolBar'
```

## Use

In your `AppDelegate.swift`:

```swift
import EFKeyboardToolBar
```

then:

```swift
EFKeyboardToolBar.enableEFKeyboardToolBar()
```

Then your `UITextField`, `UITextView`, `UISearchBar` will have toolbar in keyboard.

## Custom

White your own class follow the `EFKeyboardToolBarContentViewProtocol` protocol, and use the following code to set it:

```swift
let newConfit = EFKeyboardToolBarConfig()
newConfit.toolBarHeight = 60
newConfit.toolBarContentView = EFKeyboardToolBarCustomContentView()
EFKeyboardToolBar.setConfig(config: newConfit)
```

You can see the example code for more details.

## Author

EyreFree, eyrefree@eyrefree.org

## License

EFKeyboardToolBar is available under the MIT license. See the LICENSE file for more info.
