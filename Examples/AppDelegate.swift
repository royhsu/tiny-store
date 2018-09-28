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
        
        case postalCodeRequired
        
        case addressRequired
        
        case firstNameRequired
        
        case lastNameRequired
        
        case phoneNumberRequired
        
    }
    
    public struct FormResult: CheckoutFormResult {

        public let city: City
        
        public let postalCode: String

        public let address: String

        public let firstName: String
        
        public let lastName: String
        
        public let phoneNumber: String
        
        public init(_ fields: AnyCollection<CheckoutField>) throws {
            
            var city: City?

            var address: String?
            
            var postalCode: String?

            var firstName: String?
            
            var lastName: String?
            
            var phoneNumber: String?
            
            for field in fields {
                
                switch field {
                    
                case let .shipping(field):
                    
                    city = try field.cityField.validate()
                    
                    postalCode = try field.postalCodeField.validate()

                    address = try field.addressField.validate()
                    
                case let .recipient(field):
                    
                    firstName = try field.firstNameField.validate()
                    
                    lastName = try field.lastNameField.validate()
                    
                    phoneNumber = try field.phoneNumberField.validate()
                    
                }
                
            }
            
            if let city = city { self.city = city }
            else { throw FormResultError.cityRequired }

            if let postalCode = postalCode { self.postalCode = postalCode }
            else { throw FormResultError.postalCodeRequired }

            if let address = address { self.address = address }
            else { throw FormResultError.addressRequired }
            
            if let firstName = firstName { self.firstName = firstName }
            else { throw FormResultError.firstNameRequired }
            
            if let lastName = lastName { self.lastName = lastName }
            else { throw FormResultError.lastNameRequired }
            
            if let phoneNumber = phoneNumber { self.phoneNumber = phoneNumber }
            else { throw FormResultError.phoneNumberRequired }
            
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
