//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    public var isSeparatorHidden = false
    
    private let selectionField: CheckoutItemSelectionField
    
    private let titleField: CheckoutItemTitleField
    
    private let descriptionField: CheckoutItemDescriptionField
    
    private let priceField: CheckoutItemPriceField
    
    private let quantityField: CheckoutItemQuantityField
    
    private var views: [UIView] {
        
        return
            isSeparatorHidden
            ? [ topMarginView, itemView, bottomMarginView ]
            : [ topMarginView, itemView, bottomMarginView, separatorView ]
        
    }
    
    private let itemView: UICheckoutItemView
    
    private let topMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 12.0) ]
        )
        
        return view
        
    }()
    
    private let bottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 12.0) ]
        )
        
        return view
        
    }()
    
    private let separatorView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 0.5) ]
        )
        
        return view
        
    }()
    
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
        
        let itemView = UIView.loadView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self)
        )!
        
        itemView.isSelected = selectionField.selection.value ?? true
        
        itemView.isSelectedDidChange = { selectionField.selection.value = $0 }
        
        itemView.titleLabel.text = titleField.title.value
        
        itemView.descriptionLabel.text = descriptionField.description.value
        
        let price = priceField.price.value ?? 0.0
        
        #warning("add currency formatter.")
        itemView.priceLabel.text = "$ \(price)"
        
        itemView.quantityStepper.value = quantityField.quantity.value ?? 1
        
        itemView.quantityStepper.valueDidChange = { quantityField.quantity.value = $0 }
        
        self.itemView = itemView
        
    }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
