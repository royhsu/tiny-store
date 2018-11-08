//
//  CheckoutDefaultItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutDefaultItem

public struct CheckoutDefaultItem: CheckoutItem {
    
    private enum CodingKeys: String, CodingKey {
        
        case title = "title"
        
        case color = "color"
        
        case price = "price"
        
        case quantity = "quantity"
        
    }
    
    public let selection: CheckoutSelection
    
    public let title: CheckoutItemTitle
    
    public let description: CheckoutItemDescription
    
    public let color: CheckoutItemColor
    
    public let price: CheckoutItemPrice
    
    public let quantity: CheckoutItemQuantity
    
    public init(
        selection: CheckoutSelection,
        title: CheckoutItemTitle,
        description: CheckoutItemDescription,
        color: CheckoutItemColor,
        price: CheckoutItemPrice,
        quantity: CheckoutItemQuantity
    ) {
        
        self.selection = selection
        
        self.title = title
        
        self.description = description
        
        self.color = color
        
        self.price = price
        
        self.quantity = quantity
        
    }
    
}
