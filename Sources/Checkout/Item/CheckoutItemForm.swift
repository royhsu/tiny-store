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

// MARK: - CheckoutDefaultItemForm

public struct CheckoutDefaultItemForm: CheckoutItemForm {

    private enum CodingKeys: String, CodingKey {
        
        case titleField = "title"

        case colorField = "color"

        case priceField = "price"

        case quantityField = "quantity"

    }

    public let selectionField: CheckoutItemSelectionField
    
    public let titleField: CheckoutItemTitleField
    
    public let descriptionField: CheckoutItemDescriptionField
    
    public let colorField: CheckoutItemColorField
    
    public let priceField: CheckoutItemPriceField
    
    public let quantityField: CheckoutItemQuantityField
    
    public init(
        selectionField: CheckoutItemSelectionField,
        titleField: CheckoutItemTitleField,
        descriptionField: CheckoutItemDescriptionField,
        colorField: CheckoutItemColorField,
        priceField: CheckoutItemPriceField,
        quantityField: CheckoutItemQuantityField
    ) {
        
        self.selectionField = selectionField
        
        self.titleField = titleField
        
        self.descriptionField = descriptionField
        
        self.colorField = colorField
        
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
