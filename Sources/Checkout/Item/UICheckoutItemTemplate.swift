//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    public var isSeparatorHidden = false
    
    private let item: CheckoutItem
    
    private var views: [UIView] {
        
        return
            isSeparatorHidden
            ? [ topMarginView, itemView, bottomMarginView ]
            : [ topMarginView, itemView, bottomMarginView, separatorView ]
        
    }
    
    private let itemView: UICheckoutItemView = UIView.loadView(
        UICheckoutItemView.self,
        from: Bundle(for: UICheckoutItemView.self)
    )!
    
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
    
    public init(item: CheckoutItem) {
        
        self.item = item
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        itemView.isSelected = item.isSelected.property.value ?? true
        
        itemView.isSelectedDidChange = { self.item.isSelected.property.value = $0 }
        
        itemView.titleLabel.text = item.title.property.value
        
        itemView.descriptionLabel.text = item.description.property.value
        
        let price = item.price.property.value ?? 0.0
        
        #warning("add currency formatter.")
        itemView.priceLabel.text = "$ \(price)"
        
        itemView.quantityStepper.value = item.quantity.property.value ?? 1
        
        itemView.quantityStepper.valueDidChange = { self.item.quantity.property.value = $0 }
        
    }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
