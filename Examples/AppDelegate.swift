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

        let checkoutFlowViewController = CheckoutFlowViewController()
        
        checkoutFlowViewController.flowController = CheckoutFlowController(
            navigation: NavigationController.self,
            order: OrderViewController.self
        )
        
        switch checkoutFlowViewController.flowController?.state {
            
        case var .fillingOrder(controller)?:
            
            controller.form = [
                .item(
                    CheckoutItemField(
                        style: UICheckoutItemStyle.self,
                        title: "Chocolate Cake",
                        price: 120.0,
                        quantity: 5
                    )
                ),
                .item(
                    CheckoutItemField(
                        style: UICheckoutItemStyle.self,
                        title: "Apple Pie",
                        price: 30.0,
                        quantity: 2
                    )
                ),
                .shipping(
                    CheckoutShippingField(
                        style: UICheckoutShippingStyle.self
                    )
                ),
                .recipient(
                    CheckoutRecipientField(
                        style: UICheckoutRecipientStyle.self
                    )
                )
            ]
            
            controller.navigate { destination in
                
                if let destination = destination as? CheckoutDestination {
                    
                    switch destination {
                        
                    case let .cityPicker(completion):
                        
                        completion(Taiwan.taipei)
                        
                    }
                    
                    return
                    
                }
                
            }
            
        case .none: break
            
        }

        window.rootViewController = checkoutFlowViewController

        window.makeKeyAndVisible()

        return true

    }

}
