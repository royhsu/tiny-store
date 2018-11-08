//
//  CheckoutItemQuantity.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/30.
//

// MARK: - CheckoutItemQuantity

#warning("add default validation rules.")
public struct CheckoutItemQuantity: Content {
    
    public let property: Observable<Int>
    
    public let rules: [AnyValidationRule<Int>]
    
    public let isRequired: Bool
    
    public init(
        property: Observable<Int>,
        rules: [AnyValidationRule<Int>] = [],
        isRequired: Bool = true
    ) {
        
        self.property = property
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
