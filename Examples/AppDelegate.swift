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
        
//        let viewController = TSCheckoutViewController()
        
        let viewController = ShippingServiceListViewController()
        
        viewController.elements = [
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: false,
                        title: "UPS",
                        price: 3.0
                    )
                )
            ),
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: false,
                        title: "DHL Express",
                        price: 5.0
                    )
                )
            )
        ]
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController

        window.makeKeyAndVisible()

        return true

    }

}
