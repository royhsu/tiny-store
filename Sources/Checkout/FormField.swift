//
//  FormField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - FormField

public final class FormField<RawValue> {
    
    public final var rawValue: RawValue?
    
    public final var rules: [ AnyValidationRule<RawValue> ]
    
    public init(
        rawValue: RawValue? = nil,
        rules: [ AnyValidationRule<RawValue> ] = []
    ) {
        
        self.rawValue = rawValue
        
        self.rules = rules
        
    }
    
}

public extension FormField {
    
    /// The raw value must be not nil to pass the the validation.
    /// So you don't have to manually include NotNilRule in your rules.
    public final func validated() throws -> RawValue {
        
        let value = try rawValue.explicitlyValidated(
            by: NotNilRule()
        )
        
        try rules.forEach { rule in _ = try rule.validate(value) }
        
        return value
        
    }
    
}
