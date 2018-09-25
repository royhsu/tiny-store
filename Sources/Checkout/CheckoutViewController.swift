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

extension String: CheckoutShipping { }

extension String: CheckoutRecipient { }

public final class CheckoutViewController: CollectionViewController< MemoryCache<Int, String> > {
    
    public final var shippingTemplateType: CheckoutShippingTemplate.Type?
    
    public final var shippingAddressRules: [AnyValidationRule<String>] = [
        AnyValidationRule(
            NonEmptyRule<String>()
        )
    ]
    
    public final var recipientTemplateType: CheckoutRecipientTemplate.Type?
    
    private final var observations: [Observation] = []
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        observations.append(
            actions.observe { [weak self] change in
                
                guard
                    let self = self
                else { return }
                
                if let action = change.currentValue as? CheckoutShippingAction {
                    
                    switch action {
                        
                    case let .newInput(input):
                        
                        switch input {
                            
                        case let .city(city): print(city)
                            
                        case let .postalCode(postalCode): print(postalCode)
                            
                        case let .address(address):
                            
                            do {
                                
                                let validAddress = try address.validated(by: self.shippingAddressRules)
                                
                                print("Valid address:", validAddress)
                                    
                            }
                            catch { print("\(error)") }
                            
                        }
                        
                    }
                    
                    return
                    
                }
                
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
                        storage: "shipping",
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
