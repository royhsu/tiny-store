//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import TinyStore

@UIApplicationMain
public final class AppDelegate: UIResponder {

    public final let window = UIWindow(frame: UIScreen.main.bounds)

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
//        let viewController = UICheckoutController()

        let viewController = UIAddressActionButtonController()
        
        viewController.view.backgroundColor = .white
        
        viewController.action = AddressAction(title: "Hello")
        
        viewController.actionHandler = { print("Clicked") }
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
