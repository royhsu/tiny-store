//
//  Content.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/8.
//

// MARK: - Content

public struct Content<Value> {
    
    public let property: Observable<Value>
    
    public var rules: [AnyValidationRule<Value>]

    public var isRequired: Bool
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {
        
        self.property = Observable(value)
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
    
}
