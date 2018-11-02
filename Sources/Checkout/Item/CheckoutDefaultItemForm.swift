//
//  CheckoutDefaultItemForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

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
