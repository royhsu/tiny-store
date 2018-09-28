//
//  CheckoutCityField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutCityField

public struct CheckoutCityField: FormField {
    
    public var value: City?
    
    public let rules: [ AnyValidationRule<City> ]
    
    public let definition: FormFieldDefinition
    
    public init(
        value: City? = nil,
        rules: [ AnyValidationRule<City> ] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}
