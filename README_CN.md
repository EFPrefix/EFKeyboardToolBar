# EFKeyboardToolBar

[![CI Status](https://img.shields.io/travis/EFPrefix/EFKeyboardToolBar.svg?style=flat)](https://travis-ci.org/EFPrefix/EFKeyboardToolBar)
[![Version](https://img.shields.io/cocoapods/v/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)
[![License](https://img.shields.io/cocoapods/l/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)
[![Platform](https://img.shields.io/cocoapods/p/EFKeyboardToolBar.svg?style=flat)](https://cocoapods.org/pods/EFKeyboardToolBar)
[![QQ Group](https://img.shields.io/badge/Q群-769966374-32befc.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAQCAMAAAARSr4IAAAA4VBMVEUAAAAAAAAAAAD3rwgAAAAAAADpICBuTQNUDAwAAAAAAAAAAAAAAADnICAAAAAAAACbFRUAAAD5rgkfFgEAAADHGxu1GBhGOyQ6LhMPCgAAAAB0UQRbDAziHh7hHh5HRUEAAAAPAgIQCwEQEBAdBAQgICAvIQIvLy8+LAJAQEBJCgpWRBpbW1tfX19gYGBqZVptTARvb299VwSAgICEhISHh4ePhnGbbAWgoKCseAawsLC7gwbAwMDExMTFrKzLjgfoHx/powfqpAjvZGTw8PDxcnLxenrzj4/5rgj5x8f///9y6ONcAAAAIHRSTlMAECAgMEBQVlhggZGhobHBwdHR3eHh4+fp7/Hx9/f5+3tefS0AAACkSURBVHjaNc1FAsJAEAXRDj64BAv2IbgEd2s0gfsfiJkAtXurIpkWMQBd0K8O3KZfhWEeW9YB8LnUYY2Gi6WJqJIHwKo7GAMpRT/aV0d2BhRD/Xp7tt9OGs2yYoy5mpUxc0BOc/yvkiQSwJPZtu3XCdAoDtjMb5k8C9KN1utx+zFChsD97bYzRII0Ss2/7IUliILFjZKV8ZLM61xK+V6tsHbSRB+BYB6Vhuib7wAAAABJRU5ErkJggg==)](http://shang.qq.com/wpa/qunwpa?idkey=d0f732585dcb0c6f2eb26bc9e0327f6305d18260eeba89ed26a201b520c572c0)

EFKeyboardToolBar 是一个 Swift 编写的键盘工具条，受 [KeyboardToolBar](https://github.com/Jiar/KeyboardToolBar) 启发。

> [English Introduction](/README.md)

## 预览

| 默认 | 自定义 |
|:---------------------:|:---------------------:|
![](https://github.com/EFPrefix/EFKeyboardToolBar/blob/master/Assets/default.png?raw=true)|![](https://github.com/EFPrefix/EFKeyboardToolBar/blob/master/Assets/custom.png?raw=true)   

## 示例

1. 利用 `git clone` 命令下载本仓库；
2. 利用 cd 命令切换到 Example 目录下，执行 `pod install` 命令；
3. 随后打开 `EFKeyboardToolBar.xcworkspace` 编译即可。

或执行以下命令：

```bash
git clone git@github.com:EFPrefix/EFKeyboardToolBar.git; cd EFKeyboardToolBar/Example; pod install; open EFKeyboardToolBar.xcworkspace
```

## 环境

| 版本  | 需求                                  |
|:-----|:--------------------------------------|
| 1.x  | Xcode 9.0+<br>Swift 4.0+<br>iOS 8.0+  |
| 5.x  | Xcode 10.2+<br>Swift 5.0+<br>iOS 8.0+ |

## 安装

EFKeyboardToolBar 可以通过 [CocoaPods](http://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```ruby
pod 'EFKeyboardToolBar'
```

## 使用

首先，需要在你的 `AppDelegate.swift` 依赖该库：

```swift
import EFKeyboardToolBar
```

并在 `didFinishLaunchingWithOptions` 适当的位置添加如下代码：

```swift
EFKeyboardToolBar.enableEFKeyboardToolBar()
```

然后你的 `UITextField`, `UITextView`, `UISearchBar` 唤起键盘时就能被附加这个工具条啦。

## 自定义

编写你自己的符合 `EFKeyboardToolBarContentViewProtocol` 协议的类，然后调用如下代码即可：

```swift
let newConfit = EFKeyboardToolBarConfig()
newConfit.toolBarHeight = 60
newConfit.toolBarContentView = EFKeyboardToolBarCustomContentView()
EFKeyboardToolBar.setConfig(config: newConfit)
```

具体可参考示例代码。

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFKeyboardToolBar 基于 MIT 协议进行分发和使用，更多信息参见协议文件。
