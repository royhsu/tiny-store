//
//  CheckoutItemForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItemForm

public protocol CheckoutItemForm: Encodable {
    
    var selectionField: CheckoutItemSelectionField { get }
    
    var titleField: CheckoutItemTitleField { get }
    
    var descriptionField: CheckoutItemDescriptionField { get }
    
    var priceField: CheckoutItemPriceField { get }
    
    var quantityField: CheckoutItemQuantityField { get }
    
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
