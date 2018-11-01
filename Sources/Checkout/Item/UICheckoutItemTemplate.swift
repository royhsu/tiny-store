//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    private let titleField: CheckoutItemTitleField
    
    private let descriptionField: CheckoutItemDescriptionField
    
    private let quantityField: CheckoutItemQuantityField
    
    private let base: UICheckoutItemView
    
    public init(
        titleField: CheckoutItemTitleField,
        descriptionField: CheckoutItemDescriptionField,
        quantityField: CheckoutItemQuantityField
    ) {
        
        self.titleField = titleField
        
        self.descriptionField = descriptionField
        
        self.quantityField = quantityField
        
        let base = UIView.loadView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self)
        )!
        
        base.titleLabel.text = titleField.title.value
        
        base.descriptionLabel.text = descriptionField.description.value
        
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
