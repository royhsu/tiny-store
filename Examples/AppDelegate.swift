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
        
//        let viewController = ShippingServiceListViewController()
//
//        viewController.elements = [
//            .item(
//                TSShippingServiceViewController(
//                    service: DefaultShippingService(
//                        isSelected: false,
//                        title: "UPS",
//                        price: 3.0
//                    )
//                )
//            ),
//            .item(
//                TSShippingServiceViewController(
//                    service: DefaultShippingService(
//                        isSelected: false,
//                        title: "DHL Express",
//                        price: 5.0
//                    )
//                )
//            )
//        ]
        
        let viewController = TSShippingDestinationCardViewController(
            recipient: DefaultShippingRecipient(
                firstName: "Roy",
                lastName: "Hsu"
            ),
            address: DefaultShippingAddress(
                postalCode: TaiwanPostalCode.daAnDistrict,
                state: TaiwanCity.taipei,
                line1: "Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Maecenas faucibus mollis interdum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\n",
                line2: "Donec sed odio dui. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis risus eget urna mollis ornare vel eu leo."
            )
        )
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController

        window.makeKeyAndVisible()

        return true

    }

}
