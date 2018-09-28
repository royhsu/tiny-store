//
//  CheckoutItemField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItemField

public struct CheckoutItemField {
    
    public let identifier: UUID
    
    public let style: CheckoutItemStyle.Type
    
    public init(
        identifier: UUID = UUID(),
        style: CheckoutItemStyle.Type
    ) {
        
        self.identifier = identifier
        
        self.style = style
        
    }
    
}

