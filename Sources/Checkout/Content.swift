//
//  Content.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/8.
//

// MARK: - Content

public protocol Content: Encodable {
    
    associatedtype Value: Encodable
    
    var property: Observable<Value> { get }
    
    var rules: [AnyValidationRule<Value>] { get }
    
    var isRequired: Bool { get }
    
}

// MARK: - Encodable (Default Implementation)

public extension Content {
    
    /// The value must be not nil to pass the the validation if the property is required.
    /// Otherwise the property will only be validated if it does contain a value.
    /// You DO NOT have to manually include `NotNilRule` in rules for the property. The `isRequired` property implicitly takes care of the nil case.
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        if isRequired {
            
            let value = try property.value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            try container.encode(value)
            
        }
        else {
            
            if let value = property.value {
                
                try rules.forEach { rule in _ = try rule.validate(value) }
                
                try container.encode(value)
                
            }
            else { try container.encodeNil() }
            
        }
        
    }
    
}
