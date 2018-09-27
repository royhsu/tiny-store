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
                    address: nil
                )
            ),
            .recipient(
                CheckoutRecipientField(
                    style: UICheckoutRecipientStyle.self,
                    firstName: "a",
                    lastName: "b",
                    phoneNumber: "c"
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

    public enum FormResultError: Error {
        
        case cityRequired
        
    }
    
    public struct FormResult: CheckoutFormResult {
        
        public let city: City
        
        public let address: String?
        
        public init(_ fields: AnyCollection<CheckoutField>) throws {
            
            var city: City?
            
            var address: String?
            
            for field in fields {
                
                switch field {
                    
                case let .shipping(field):
                    
                    city = try field.city?.validated()
                        
                    address = try field.address?.validated()
                    
                case let .recipient(field): break
                    
                }
                
            }
            
            guard
                let validCity = city
            else { throw FormResultError.cityRequired }
            
            self.city = validCity
            
            self.address = address
            
        }
        
    }
    
    @objc
    public final func done(_ item: UIBarButtonItem) {

        do {

            guard
                let result = try checkoutViewController.form?.export(FormResult.self)
            else { return }

            print("Done", result)

        }
        catch { print("\(error)") }

    }

}
