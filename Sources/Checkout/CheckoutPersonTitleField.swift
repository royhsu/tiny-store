//
//  CheckoutPersonTitleField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutPersonTitleField

public struct CheckoutPersonTitleField: FormField {
    
    public var value: String?
    
    public let rules: [ AnyValidationRule<String> ]
    
    public let definition: FormFieldDefinition
    
    public init(
        value: String? = nil,
        rules: [ AnyValidationRule<String> ] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}
