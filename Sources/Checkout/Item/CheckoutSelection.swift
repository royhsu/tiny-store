//
//  CheckoutSelection.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutSelection

public struct CheckoutSelection: Content {
    
    public let property: Observable<Bool>
    
    public let rules: [AnyValidationRule<Bool>]
    
    public let isRequired: Bool
    
    public init(
        property: Observable<Bool>,
        rules: [AnyValidationRule<Bool>] = [],
        isRequired: Bool = true
    ) {
        
        self.property = property
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
