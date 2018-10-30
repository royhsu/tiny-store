//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import PatissierStore

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

//        let orderViewController = OrderViewController()
//
//        orderViewController.form = [
//            .item(
//                CheckoutItemField(
//                    style: UICheckoutItemStyle.self,
//                    title: "Chocolate Cake",
//                    price: 120.0,
//                    quantity: 5
//                )
//            ),
//            .item(
//                CheckoutItemField(
//                    style: UICheckoutItemStyle.self,
//                    title: "Apple Pie",
//                    price: 30.0,
//                    quantity: 2
//                )
//            ),
//            .shipping(
//                CheckoutShippingField(
//                    style: UICheckoutShippingStyle.self
//                )
//            ),
//            .recipient(
//                CheckoutRecipientField(
//                    style: UICheckoutRecipientStyle.self
//                )
//            )
//        ]
//
//        let checkoutFlowViewController = CheckoutFlowController()
//
//        checkoutFlowViewController.orderFillingStep = orderViewController
//
//        let orderPreviewViewController = CheckoutOrderPreviewingViewController()
//
//        checkoutFlowViewController.orderPreviewingStep = orderPreviewViewController
//
//        window.rootViewController = checkoutFlowViewController
        
        let collectionViewController = CollectionViewController()
        
        collectionViewController.collectionView.applyLayout(ListViewLayout.self)
        
        struct Item: NewCheckoutItem {
            
            let title: String
            
            let price: Double
            
            let quantityField = NewCheckoutQuantityField()
            
        }
        
        collectionViewController.collectionView.sections = [
            NewCheckoutItemTemplate(
                storage: Item(
                    title: "Knee-length Wool Skirt",
                    price: 19.0
                ),
                elements: [ .title ]
            )
        ]

        window.rootViewController = collectionViewController
        
        window.makeKeyAndVisible()

        return true

    }

}
