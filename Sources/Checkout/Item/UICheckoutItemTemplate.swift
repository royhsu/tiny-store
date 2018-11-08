//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    public var isSeparatorHidden = false
    
    private let selectionField: CheckoutItemSelection
    
    private let titleField: CheckoutItemTitle
    
    private let descriptionField: CheckoutItemDescription
    
    private let priceField: CheckoutItemPrice
    
    private let quantityField: CheckoutItemQuantity
    
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
        selectionField: CheckoutItemSelection,
        titleField: CheckoutItemTitle,
        descriptionField: CheckoutItemDescription,
        priceField: CheckoutItemPrice,
        quantityField: CheckoutItemQuantity
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
        
        itemView.isSelected = selectionField.property.value ?? true
        
        itemView.isSelectedDidChange = { selectionField.property.value = $0 }
        
        itemView.titleLabel.text = titleField.property.value
        
        itemView.descriptionLabel.text = descriptionField.property.value
        
        let price = priceField.property.value ?? 0.0
        
        #warning("add currency formatter.")
        itemView.priceLabel.text = "$ \(price)"
        
        itemView.quantityStepper.value = quantityField.property.value ?? 1
        
        itemView.quantityStepper.valueDidChange = { quantityField.property.value = $0 }
        
        self.itemView = itemView
        
    }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
