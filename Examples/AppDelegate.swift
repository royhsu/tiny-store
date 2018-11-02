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
        
        let cartViewController = CheckoutCartViewController()
        
        let selection = Observable<Bool>()
        
        selection.value = true
        
        let title = Observable<String>()
        
        title.value = "Knee-length Wool Skirt"
        
        let description = Observable<String>()
        
        description.value = "Dark Blue - S"
        
        let price = Observable<Double>()
        
        price.value = 19.0
        
        let quantity = Observable<Int>()
        
        quantity.value = 3
        
        let itemForm = CheckoutItemForm(
            selectionField: .init(selection: selection),
            titleField: .init(title: title),
            descriptionField: .init(description: description),
            priceField: .init(price: price),
            quantityField: .init(quantity: quantity)
        )
        
        cartViewController.itemForms = [ itemForm ]
        
        do {
        
            let data = try JSONEncoder().encode(itemForm)
        
            let json = try JSONSerialization.jsonObject(with: data)
            
            print(json)
            
        }
        catch { print("\(error)") }

        window.rootViewController = cartViewController
        
        window.makeKeyAndVisible()

        return true

    }

}
