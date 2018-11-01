//
//  UICheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutItemTemplate

public struct UICheckoutItemTemplate: Template {
    
    private let titleField: CheckoutItemTitleField
    
    private let base: UICheckoutItemView
    
    public init(
        titleField: CheckoutItemTitleField
    ) {
        
        self.titleField = titleField
        
        let base = UIView.loadView(
            UICheckoutItemView.self,
            from: Bundle(for: UICheckoutItemView.self)
        )!
        
        base.titleLabel.text = titleField.title.value
        
        self.base = base
        
    }
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return base }
    
}
