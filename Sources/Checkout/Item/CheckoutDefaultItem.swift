//
//  CheckoutDefaultItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutDefaultItem

public struct CheckoutDefaultItem: CheckoutItem {
    
    private enum CodingKeys: String, CodingKey {
        
        case titleField = "title"
        
        case colorField = "color"
        
        case priceField = "price"
        
        case quantityField = "quantity"
        
    }
    
    public let selectionField: CheckoutItemSelection
    
    public let titleField: CheckoutItemTitle
    
    public let descriptionField: CheckoutItemDescription
    
    public let colorField: CheckoutItemColor
    
    public let priceField: CheckoutItemPrice
    
    public let quantityField: CheckoutItemQuantity
    
    public init(
        selectionField: CheckoutItemSelection,
        titleField: CheckoutItemTitle,
        descriptionField: CheckoutItemDescription,
        colorField: CheckoutItemColor,
        priceField: CheckoutItemPrice,
        quantityField: CheckoutItemQuantity
    ) {
        
        self.selectionField = selectionField
        
        self.titleField = titleField
        
        self.descriptionField = descriptionField
        
        self.colorField = colorField
        
        self.priceField = priceField
        
        self.quantityField = quantityField
        
    }
    
}
