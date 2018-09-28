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
                    postalCodeField: CheckoutPostalCodeField(definition: .optional)
                )
            ),
            .recipient(
                CheckoutRecipientField(
                    style: UICheckoutRecipientStyle.self,
                    firstNameField: CheckoutFirstNameField(definition: .optional)
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
        
        case addressRequired
        
        case lastNameRequired
        
        case phoneNumberRequired
        
    }
    
    public struct FormResult: CheckoutFormResult {

        public let city: City

        public let address: String

        public let firstName: String?
        
        public let lastName: String
        
        public let phoneNumber: String
        
        public init(_ fields: AnyCollection<CheckoutField>) throws {
            
            var city: City?

            var address: String?

            var firstName: String?
            
            var lastName: String?
            
            var phoneNumber: String?
            
            for field in fields {
                
                switch field {
                    
                case let .shipping(field):
                    
                    city = try field.cityField.validate()

                    address = try field.addressField.validate()
                    
                case let .recipient(field):
                    
                    firstName = try field.firstNameField.validate()
                    
                    lastName = try field.lastNameField.validate()
                    
                    phoneNumber = try field.phoneNumberField.validate()
                    
                }
                
            }
            
            guard
                let validCity = city
            else { throw FormResultError.cityRequired }

            self.city = validCity

            guard
                let validAddress = address
            else { throw FormResultError.addressRequired }
            
            self.address = validAddress
            
            self.firstName = firstName
            
            guard
                let validLastName = lastName
            else { throw FormResultError.lastNameRequired }
            
            self.lastName = validLastName
            
            guard
                let validPhoneNumber = phoneNumber
            else { throw FormResultError.phoneNumberRequired }
            
            self.phoneNumber = validPhoneNumber
            
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
