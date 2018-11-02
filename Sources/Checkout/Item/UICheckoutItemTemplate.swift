//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    private let selectionField: CheckoutItemSelectionField
    
    private let titleField: CheckoutItemTitleField
    
    private let descriptionField: CheckoutItemDescriptionField
    
    private let priceField: CheckoutItemPriceField
    
    private let quantityField: CheckoutItemQuantityField
    
    private let base: UICheckoutItemView
    
    public init(
        selectionField: CheckoutItemSelectionField,
        titleField: CheckoutItemTitleField,
        descriptionField: CheckoutItemDescriptionField,
        priceField: CheckoutItemPriceField,
        quantityField: CheckoutItemQuantityField
    ) {
        
        self.selectionField = selectionField
        
        self.titleField = titleField
        
        self.descriptionField = descriptionField
        
        self.priceField = priceField
        
        self.quantityField = quantityField
        
        let base = UIView.loadView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self)
        )!
        
        base.selectionView.isSelected = selectionField.selection.value ?? true
        
        base.titleLabel.text = titleField.title.value
        
        base.descriptionLabel.text = descriptionField.description.value
        
        let price = priceField.price.value ?? 0.0
        
        #warning("add currency formatter.")
        base.priceLabel.text = "$ \(price)"
        
        base.quantityStepper.value = quantityField.quantity.value ?? 1
        
        base.quantityStepper.valueDidChange = { value in
            
            quantityField.quantity.value = value
            
            print(quantityField.quantity.value)
            
        }
        
        self.base = base
        
    }
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return base }
    
}
