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
        
        let cartViewController = CheckoutCartViewController<CheckoutDefaultItemForm>()
        
        struct Item {
            
            let title: String
            
            let color: String
            
            let size: String
            
            let price: Double
            
        }
        
        let items = [
            Item(
                title: "Knee-length Wool Skirt",
                color: "Dark Blue",
                size: "S",
                price: 19.0
            )
        ]
        
        cartViewController.itemForms = items.map { item in
            
            let selection = Observable<Bool>()
            
            selection.value = true
            
            let title = Observable<String>()
    
            title.value = item.title
    
            let description = Observable<String>()
            
            description.value = "\(item.color) - \(item.size)"
            
            let color = Observable<String>()
    
            color.value = item.color
            
            let price = Observable<Double>()
    
            price.value = item.price
    
            let quantity = Observable<Int>()
    
            quantity.value = 1

            return CheckoutDefaultItemForm(
                selectionField: .init(selection: selection),
                titleField: .init(title: title),
                descriptionField: .init(description: description),
                colorField: .init(color: color),
                priceField: .init(price: price),
                quantityField: .init(quantity: quantity)
            )
            
        }
        
        do {

            let data = try JSONEncoder().encode(cartViewController.itemForms)
            
            let json = try JSONSerialization.jsonObject(with: data)
            
            print(json)
            
        }
        catch { print("\(error)") }
        
        window.rootViewController = cartViewController
        
        window.makeKeyAndVisible()

        return true

    }

}
