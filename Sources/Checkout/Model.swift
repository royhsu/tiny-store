//
//  Model.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

// MARK: - Model

public struct Model<Value> {
    
    public let storage: Observable<Value>
    
    public var rules: [AnyValidationRule<Value>]
    
    public var isRequired: Bool
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {
        
        self.storage = Observable(value)
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}

public extension Model {
    
    public func validate() throws -> Value? {
        
        if isRequired {
            
            let value = try storage.value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            return value
            
        }
        else {
            
            guard let value = storage.value else { return nil }
                
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            return value
            
        }
        
    }
    
}
