//
//  CheckoutItemPrice.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemPrice

#warning("add default validation rules.")
public struct CheckoutItemPrice: Content {
    
    public let property: Observable<Double>
    
    public let rules: [AnyValidationRule<Double>]
    
    public let isRequired: Bool
    
    public init(
        property: Observable<Double>,
        rules: [AnyValidationRule<Double>] = [],
        isRequired: Bool = true
    ) {
        
        self.property = property
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
