//
//  CheckoutPhoneNumber.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutPhoneNumber

public struct CheckoutPhoneNumber: Content {
    
    public let property: Observable<String>
    
    public let rules: [AnyValidationRule<String>]
    
    public let isRequired: Bool
    
    public init(
        property: Observable<String>,
        rules: [AnyValidationRule<String>] = [ .notEmpty ],
        isRequired: Bool = true
    ) {
        
        self.property = property
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
