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
        
        let viewController = UIDashboardViewController()
        
        viewController.view.backgroundColor = .red
        
        struct SubRow: DashboardRow {
            
            let title: Content<String>
            
            let amount: Content<Double>
            
            init(title: String, amount: Double) {
                
                self.title = Content(value: title)
                
                self.amount = Content(value: amount)
                
            }
            
        }
        
        viewController.dashboard.elements = [
            .subRow(
                UIDashboardSubRowViewController(
                    SubRow(
                        title: "SubTotal",
                        amount: 0.0
                    )
                )
            ),
            .subRow(
                UIDashboardSubRowViewController(
                    SubRow(
                        title: "Shipping",
                        amount: 0.0
                    )
                )
            )
        ]
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
