//
//  CheckoutFieldValue.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutFieldValue

public protocol CheckoutFieldValue {
    
    associatedtype RawValue
    
    var rawValue: RawValue? { get set }
    
    var rules: [ AnyValidationRule<RawValue> ] { get }
    
}

public extension CheckoutFieldValue {
    
    /// The raw value must be not nil to pass the the validation.
    /// So you don't have to manually include NotNilRule in your rules.
    public func validated() throws -> RawValue {
        
        let value = try rawValue.explicitlyValidated(
            by: NotNilRule()
        )
        
        try rules.forEach { rule in _ = try rule.validate(value) }
        
        return value
        
    }
    
}

