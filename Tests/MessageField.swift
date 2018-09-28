//
//  MessageField.swift
//  TinyStoreTests
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - MessageField

import TinyStore

internal struct MessageField: FormField {
    
    internal var value: String?
    
    internal let rules: [ AnyValidationRule<String> ]
    
    internal let definition: FormFieldDefinition
    
    internal init(
        value: String? = nil,
        rules: [ AnyValidationRule<String> ] = [ .notEmpty ],
        definition: FormFieldDefinition = .required
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}
