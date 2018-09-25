//
//  CheckoutForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutForm

import TinyCore
import TinyValidation

public struct CheckoutForm {
    
    private struct _Shipping: CheckoutShipping {
        
        internal var address = ""
        
    }
    
    public var shipping: CheckoutShipping = _Shipping()
    
    public var shippingAddressRules: [AnyValidationRule<String>] = [
        AnyValidationRule(
            NonEmptyRule<String>()
        )
    ]
    
    private weak var errors: Observable<Error>?
    
    public init(errors: Observable<Error>) { self.errors = errors }
    
    public struct Result {
        
        public struct Shipping {
            
            public let address: String
            
            public init(address: String) { self.address = address }
            
        }
        
        public let shipping: Shipping
        
        public init(shipping: Shipping) { self.shipping = shipping }
        
    }
    
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

