//
//  CheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutViewController

import TinyCore
import TinyStorage
import TinyKit
import TinyValidation

extension String: CheckoutRecipient { }

public final class CheckoutViewController: CollectionViewController< MemoryCache<Int, String> > {
    
    private struct Shipping: CheckoutShipping {
        
        internal var address = ""
        
    }
    
    public struct Form {
        
        public var shipping: CheckoutShipping = Shipping()
        
        public var shippingAddressRules: [AnyValidationRule<String>] = [
            AnyValidationRule(
                NonEmptyRule<String>()
            )
        ]
        
        private weak var errors: Observable<Error>?
        
        public init(errors: Observable<Error>) { self.errors = errors }
        
        public func validate() -> Result? {
            
            do {
            
                let validAddress = try shipping.address.validated(by: shippingAddressRules)
                
                return Result(
                    shipping: .init(
                        address: validAddress
                    )
                )
                
            }
            catch {
                
                errors?.value = error
                
                return nil
                
            }
            
        }
        
    }

    public struct Result {
        
        public struct Shipping {
            
            public let address: String
            
            public init(address: String) { self.address = address }
            
        }
        
        public let shipping: Shipping
        
        public init(shipping: Shipping) { self.shipping = shipping }
        
    }
    
    public final lazy var form: Form = { return Form(errors: errors) }()
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var observations: [Observation] = []
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        observations.append(
            actions.observe { [unowned self] change in
                
                if let action = change.currentValue as? CheckoutShippingAction {
                    
                    switch action {
                        
                    case let .newInput(input):
                        
                        switch input {
                            
                        case let .city(city): print(city)
                            
                        case let .postalCode(postalCode): print(postalCode)
                            
                        case let .address(address): self.form.shipping.address = address
                        
                        }
                        
                    }
                    
                    return
                    
                }
                
            }
        )
        
        observations.append(
            errors.observe { change in
                
                guard
                    let error = change.currentValue
                else { return }
                
                #warning("TODO: delegating errors.")
                print("\(error)")
                
            }
        )
        
        storageReducer = { [unowned self] storage in

            var templates: [Template] = []
            
            guard
                let shippingTemplateType = self.shippingTemplateType
            else { fatalError("Must provide a shipping template") }
            
            guard
                let recipientTemplateType = self.recipientTemplateType
            else { fatalError("Must provide a recipient template") }
            
            templates.append(
                CheckoutTemplate.shipping(
                    shippingTemplateType.init(
                        storage: self.form.shipping,
                        reducer: { storage in
                            
                            return [
                                .header,
                                .form
                            ]
                            
                        }
                    )
                )
            )
            
            templates.append(
                CheckoutTemplate.recipient(
                    recipientTemplateType.init(
                        storage: "recpient",
                        reducer: { storage in

                            return [
                                .header,
                                .form
                            ]

                        }
                    )
                )
            )
            
            return templates
            
        }
        
//            let redView = View()
//
//            redView.backgroundColor = .red
//
//            redView.translatesAutoresizingMaskIntoConstraints = false
//
//            redView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
//
//            let template: Template = [ redView ]
//
//            return [ template ]
        
    }
    
}
