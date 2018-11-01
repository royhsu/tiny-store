//
//  CheckoutItemForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItemForm

public struct CheckoutItemForm: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        
        case titleField = "title"
        
        case descriptionField = "description"
        
        case priceField = "price"
        
        case quantityField = "quantity"
        
    }
    
    public let titleField: CheckoutItemTitleField
    
    public let descriptionField: CheckoutItemDescriptionField
    
    public let priceField: CheckoutItemPriceField
    
    public let quantityField: CheckoutItemQuantityField
    
    public init(
        titleField: CheckoutItemTitleField,
        descriptionField: CheckoutItemDescriptionField,
        priceField: CheckoutItemPriceField,
        quantityField: CheckoutItemQuantityField
    ) {
        
        self.titleField = titleField
        
        self.descriptionField = descriptionField
        
        self.priceField = priceField
        
        self.quantityField = quantityField
        
    }
    
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
