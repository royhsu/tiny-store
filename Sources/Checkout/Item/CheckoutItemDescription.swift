//
//  CheckoutItemDescription.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemDescription

public struct CheckoutItemDescription: Content {
    
    public let property: Observable<String>
    
    public let rules: [AnyValidationRule<String>]
    
    public let isRequired: Bool
    
    public init(
        property: Observable<String>,
        rules: [AnyValidationRule<String>] = [],
        isRequired: Bool = true
    ) {
        
        self.property = property
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
