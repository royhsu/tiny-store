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
        
        let viewController = NewShippingServiceListViewController()
        
        viewController.elements = [
            .item(
                TSShippingServiceViewController(
                    Service(
                        isSelected: false,
                        title: "UPS",
                        price: 3.0
                    )
                )
            ),
            .item(
                TSShippingServiceViewController(
                    Service(
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

internal struct Service: ShippingService {
    
    internal var isSelected: Model<Bool>
    
    internal var title: Model<String>
    
    internal var price: Model<Double>
    
    internal init(
        isSelected: Bool = false,
        title: String,
        price: Double
        ) {
        
        self.isSelected = Model(value: isSelected)
        
        self.title = Model(value: title)
        
        self.price = Model(value: price)
        
    }
    
}
