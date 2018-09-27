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
            .shipping(
                CheckoutShippingField(
                    style: UICheckoutShippingStyle.self,
                    address: "hello"
                )
            ),
            .recipient(
                CheckoutRecipientField(
                    style: UICheckoutRecipientStyle.self,
                    firstName: "world"
                )
            )
        ]

        checkoutViewController.navigate { destination in

            if let destination = destination as? CheckoutDestination {

                switch destination {

                case let .cityPicker(handler):

                    handler(Taiwan.taipei)

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
                let results = try checkoutViewController.form?.validateAll()
            else { return }

            print("Done", results)

        }
        catch { print("\(error)") }

    }

}
