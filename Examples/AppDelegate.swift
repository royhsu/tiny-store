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
        
//        let cartViewController = CheckoutCartViewController<CheckoutDefaultItemForm>()

//
//        do {
//
//            let data = try JSONEncoder().encode(cartViewController.itemForms)
//
//            let json = try JSONSerialization.jsonObject(with: data)
//
//            print(json)
//
//        }
//        catch { print("\(error)") }
        
//        let viewController = UICheckoutDashboardViewController()
//
//        viewController.view.backgroundColor = .white
        
//        let viewController = UICheckoutController()

        struct Service: ShippingService {

            let isSelected: Content<Bool>

            let title: Content<String>

            let price: Content<Double>

            init(
                isSelected: Bool = false,
                title: String,
                price: Double
            ) {

                self.isSelected = Content(value: isSelected)

                self.title = Content(value: title)

                self.price = Content(value: price)

            }

        }
//
//        let viewController = CheckoutShippingViewController(
//            [
//                .service(
//                    UICheckoutShippingServiceTemplate(
//                        Service(
//                            isSelected: false,
//                            title: "UPS",
//                            price: 3.0
//                        )
//                    )
//                ),
//                .service(
//                    UICheckoutShippingServiceTemplate(
//                        Service(
//                            isSelected: false,
//                            title: "DHL Express",
//                            price: 3.0
//                        )
//                    )
//                )
//            ]
//        )
//
//        viewController.view.backgroundColor = .white
        
        let viewController = UIShippingServiceViewController()
        
        viewController.view.backgroundColor = .white
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3.0) {
            
            viewController.service = Service(
                isSelected: false,
                title: "UPS",
                price: 3.0
            )
            
        }

        return true

    }

}
