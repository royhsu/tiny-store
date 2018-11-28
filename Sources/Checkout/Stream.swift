//
//  Stream.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

// MARK: - Stream

@objcMembers
public final class Stream<Value>: NSObject {
    
    public dynamic var value: Value?
    
    public init(_ value: Value?) { self.value = value }
    
}

// MARK: - Model

public struct Model<Value> {
    
    public let storage: Stream<Value>
    
    public var rules: [AnyValidationRule<Value>]
    
    public var isRequired: Bool
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {
        
        self.storage = Stream(value)
        
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
