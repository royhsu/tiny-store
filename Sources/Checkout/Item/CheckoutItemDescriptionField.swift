//
//  CheckoutItemDescriptionField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemDescriptionField

public struct CheckoutItemDescriptionField {
    
    public let description: Observable<String>
    
    public init(description: Observable<String>) { self.description = description }
    
}
