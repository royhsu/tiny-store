//
//  Stream.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

@objcMembers
public final class Stream<Value> {
    
    public dynamic var value: Value?
    
    public init(_ value: Value?) { self.value = value }
    
}

public struct Input<Value> {
    
    public let stream: Stream<Value>
    
    public var rules: [AnyValidationRule<Value>]
    
    public var isRequired: Bool
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {
        
        self.stream = Stream(value)
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}

public extension Input {
    
    public func validate() throws -> Value? {
        
        if isRequired {
            
            let value = try stream.value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            return value
            
        }
        else {
            
            guard let value = stream.value else { return nil }
                
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            return value
            
        }
        
    }
    
}
