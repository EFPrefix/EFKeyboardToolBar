//
//  AppDelegate.swift
//  EFKeyboardToolBar
//
//  Created by EyreFree on 09/10/2018.
//  Copyright (c) 2018 EyreFree. All rights reserved.
//

import UIKit
import EFKeyboardToolBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        EFKeyboardToolBar.enableEFKeyboardToolBar()
        return true
    }
}
