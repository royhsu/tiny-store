//
//  FormField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - FormField

public protocol NewFormField {

    associatedtype Value
    
    var value: Value? { get set }
    
    var rules: [ AnyValidationRule<Value> ] { get }
    
    var definition: FormFieldDefinition { get }
 
}

public extension NewFormField {
    
    /// The value must be not nil to pass the the validation if the field marked as `.required`.
    /// And notice that an `.optional` field will only be validated if it does contain a value.
    /// You don't have to manually include `NotNilRule` in rules for the field.
    public func validate() throws -> Value? {
        
        switch definition {
            
        case .required:
            
            let unwrappedValue = try value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(unwrappedValue) }
            
            return unwrappedValue
            
        case .optional:
            
            if let unwrappedValue = value {
                
                try rules.forEach { rule in try rule.validate(unwrappedValue) }
                
                return unwrappedValue
                
            }
            
            return nil
            
        }
        
    }
    
}


public class FormField<Value> {
    
    public var value: Value?
    
    public typealias Rule = AnyValidationRule<Value>
    
    public let rules: [Rule]
    
    public let definition: FormFieldDefinition
    
    public init(
        value: Value?,
        rules: [Rule],
        definition: FormFieldDefinition
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}

public extension FormField {
    
    /// The value must be not nil to pass the the validation if the field marked as `.required`.
    /// And notice that an `.optional` field will only be validated if it does contain a value.
    /// You don't have to manually include `NotNilRule` in rules for the field.
    public func validate() throws -> Value? {
        
        switch definition {
            
        case .required:
            
            let unwrappedValue = try value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(unwrappedValue) }
            
            return unwrappedValue
            
        case .optional:
            
            if let unwrappedValue = value {
                
                try rules.forEach { rule in try rule.validate(unwrappedValue) }
                
                return unwrappedValue
                
            }
            
            return nil
            
        }
        
    }
    
}