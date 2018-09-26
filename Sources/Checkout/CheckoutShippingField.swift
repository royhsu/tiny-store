//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingField

import TinyCore
import TinyValidation

public final class CheckoutShippingField: Unique {
    
    public final let identifier = UUID()
    
    public final var address: String
    
    public final var addressRules: [ AnyValidationRule<String> ]
    
    public init(
        address: String,
        addressRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NonEmptyRule<String>()
            )
        ]
    ) {
        
        self.address = address
        
        self.addressRules = addressRules
        
    }
    
    public func validate() throws -> CheckoutShippingResult {
 
        return CheckoutShippingResult(
            identifier: identifier,
            address: try address.validated(by: addressRules)
        )

    }
    
}
