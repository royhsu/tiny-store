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

//        let viewController = UICheckoutController()
        
        struct Recipient: ShippingRecipient {
            
            let name: Content<String>
            
            init(name: String) { self.name = Content(value: name) }
            
        }
        
        struct Address: ShippingAddress {
            
            let title: Content<String>
            
            let postalCode: Content<String>
            
            let country: Content<String>
            
            let state: Content<String>
            
            let city: Content<String>
            
            let line1: Content<String>
            
            let line2: Content<String>
            
            init(
                title: String,
                postalCode: String,
                country: String,
                state: String,
                city: String,
                line1: String,
                line2: String
            ) {
                
                self.title = Content(value: title)
                
                self.postalCode = Content(value: postalCode)
                
                self.country = Content(value: country)
                
                self.state = Content(value: state)
                
                self.city = Content(value: city)
                
                self.line1 = Content(value: line1)
                
                self.line2 = Content(value: line2)
                
            }
            
        }
        
        struct Destination: ShippingDestination {
            
            let recipient: ShippingRecipient
            
            let address: ShippingAddress
    
        }
        
        let viewController = ShippingController()
        
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
        
        viewController.serviceList.elements = [
            .item(
                UIShippingServiceViewController(
                    Service(
                        isSelected: false,
                        title: "UPS",
                        price: 3.0
                    )
                )
            ),
            .item(
                UIShippingServiceViewController(
                    Service(
                        isSelected: false,
                        title: "DHL Express",
                        price: 5.0
                    )
                )
            )
        ]

        viewController.destination = Destination(
            recipient:
            Recipient(name: "Emily"),
            address: Address(
                title: "Company",
                postalCode: "10600",
                country: "US",
                state: "CA",
                city: "Cupertino",
                line1: "North Tantau Avenue",
                line2: "4F"
            )
        )

        viewController.view.backgroundColor = .red
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()

        return true

    }

}
