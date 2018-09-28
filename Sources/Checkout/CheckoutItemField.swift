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
    
    public let title: String
    
    public let price: Double
    
    public var quantity: UInt
    
    public init(
        identifier: UUID = UUID(),
        style: CheckoutItemStyle.Type,
        title: String,
        price: Double,
        quantity: UInt
    ) {
        
        self.identifier = identifier
        
        self.style = style
        
        self.title = title
        
        self.price = price
        
        self.quantity = quantity
        
    }
    
}

