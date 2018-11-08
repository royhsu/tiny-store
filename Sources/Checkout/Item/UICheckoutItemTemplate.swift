//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    public var isSeparatorHidden = false
    
    private let selection: CheckoutSelection
    
    private let title: CheckoutItemTitle
    
    private let description: CheckoutItemDescription
    
    private let price: CheckoutItemPrice
    
    private let quantity: CheckoutItemQuantity
    
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
        selection: CheckoutSelection,
        title: CheckoutItemTitle,
        description: CheckoutItemDescription,
        price: CheckoutItemPrice,
        quantity: CheckoutItemQuantity
    ) {
        
        self.selection = selection
        
        self.title = title
        
        self.description = description
        
        self.price = price
        
        self.quantity = quantity
        
        let itemView = UIView.loadView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self)
        )!
        
        itemView.isSelected = selection.property.value ?? true
        
        itemView.isSelectedDidChange = { selection.property.value = $0 }
        
        itemView.titleLabel.text = title.property.value
        
        itemView.descriptionLabel.text = description.property.value
        
        let price = price.property.value ?? 0.0
        
        #warning("add currency formatter.")
        itemView.priceLabel.text = "$ \(price)"
        
        itemView.quantityStepper.value = quantity.property.value ?? 1
        
        itemView.quantityStepper.valueDidChange = { quantity.property.value = $0 }
        
        self.itemView = itemView
        
    }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
