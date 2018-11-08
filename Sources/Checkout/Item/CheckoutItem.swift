//
//  CheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItem

public protocol CheckoutItem: Encodable {
    
    var selectionField: CheckoutItemSelection { get }
    
    var titleField: CheckoutItemTitle { get }
    
    var descriptionField: CheckoutItemDescription { get }
    
    var priceField: CheckoutItemPrice { get }
    
    var quantityField: CheckoutItemQuantity { get }
    
}

@available(*, deprecated: 1.0, message: "Please use CheckoutItemForm instead.")
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
