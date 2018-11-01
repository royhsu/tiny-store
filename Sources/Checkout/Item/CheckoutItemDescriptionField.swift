//
//  CheckoutItemDescriptionField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemDescriptionField

public struct CheckoutItemDescriptionField: Field {
    
    public let description: Observable<String>
    
    public var content: Observable<String> { return description }
    
    public let rules: [AnyValidationRule<String>] = []
    
    public init(description: Observable<String>) { self.description = description }
    
}
