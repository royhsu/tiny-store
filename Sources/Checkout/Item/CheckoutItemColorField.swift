//
//  CheckoutItemColorField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutItemColorField

public struct CheckoutItemColorField: Field {
    
    public let color: Observable<String>
    
    public var content: Observable<String> { return color }
    
    public let rules: [AnyValidationRule<String>] = []
    
    public let isRequired = true
    
    public init(color: Observable<String>) { self.color = color }
    
}
