//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingField

public final class CheckoutShippingField: Unique {
    
    public final let identifier = UUID()
    
    public final let style: CheckoutShippingStyle.Type
    
    public final var address: String
    
    public final var addressRules: [ AnyValidationRule<String> ]
    
    public init(
        style: CheckoutShippingStyle.Type,
        address: String,
        addressRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NonEmptyRule<String>()
            )
        ]
    ) {
        
        self.style = style
        
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
