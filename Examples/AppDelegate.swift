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

    private final let checkoutViewController = CheckoutViewController()

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {

    public enum Taiwan: City {

        case taipei
        
        public var name: String {
            
            switch self {
                
            case .taipei: return "Taipei"
                
            }
            
        }

    }

    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {

        checkoutViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )

        checkoutViewController.form = [
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

        checkoutViewController.navigate { destination in

            if let destination = destination as? CheckoutDestination {

                switch destination { 

                case let .cityPicker(completion):

                    completion(Taiwan.taipei)

                }

                return

            }

        }

        window.rootViewController = UINavigationController(rootViewController: checkoutViewController)

        window.makeKeyAndVisible()

        return true

    }
    
    @objc
    public final func done(_ item: UIBarButtonItem) {

        do {

            guard
                let result = try checkoutViewController.form?.export(CheckoutResult.self)
            else { return }

            print("Done", result)

        }
        catch { print("\(error)") }

    }

}
