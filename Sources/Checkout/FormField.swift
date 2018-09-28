//
//  FormField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - FormField

#warning("missing test.")
#warning("This approach cannot protect api mis-use, e.g. passing without correct default rules for dedicate fields.")
public final class FormField<RawValue> {
    
    public final var rawValue: RawValue?
    
    public final var rules: [ AnyValidationRule<RawValue> ]
    
    public final var definition: FormFieldDefinition
    
    public init(
        rawValue: RawValue? = nil,
        rules: [ AnyValidationRule<RawValue> ] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        self.rawValue = rawValue
        
        self.rules = rules
        
        self.definition = definition
        
    }
    
}

#warning("missing test.")
public extension FormField {
    
    /// The raw value must be not nil to pass the the validation.
    /// So you don't have to manually include NotNilRule in your rules.
    public final func validate() throws -> RawValue? {
        
        switch definition {
            
        case .required:
            
            let value = try rawValue.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            return value
            
        case .optional:
            
            var value: RawValue?
            
            if let rawValue = rawValue {
                
                try rules.forEach { rule in try rule.validate(rawValue) }
                
                value = rawValue
                
            }
            
            return value
            
        }
        
        
    }
    
}
