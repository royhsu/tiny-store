//
//  CheckoutItemQuantityField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/30.
//

// MARK: - CheckoutItemQuantityField

public struct CheckoutItemQuantityField: Field {
    
    public let quantity: Observable<Int>
    
    public var content: Observable<Int> { return quantity }
    
    #warning("add validation rules.")
    public let rules: [ AnyValidationRule<Int> ]

    public let definition: FormFieldDefinition
    
    public init(
        quantity: Observable<Int>,
        rules: [ AnyValidationRule<Int> ] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        self.quantity = quantity
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}
