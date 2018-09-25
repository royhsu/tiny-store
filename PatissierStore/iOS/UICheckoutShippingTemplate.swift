//
//  UICheckoutShippingTemplate.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/25.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutShippingTemplate

import TinyKit
import TinyStore

public struct UICheckoutShippingTemplate: CheckoutShippingTemplate {
    
    public struct Configuration: TemplateConfiguration {
        
        public typealias Element = UICheckoutShippingTemplate.Element
        
    }
    
    private let template: ConfigurableTemplate<CheckoutShipping, Configuration>
    
    private let key: Int
    
    public init(
        key: Int,
        storage: CheckoutShipping,
        reducer: (CheckoutShipping) -> [Element]
    ) {
        
        self.key = key
        
        self.template = ConfigurableTemplate(
            storage: storage,
            elements: reducer(storage)
        )
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        template.registerView(
            UICheckoutSectionHeaderView.self,
            from: Bundle(for: UICheckoutSectionHeaderView.self),
            binding: { storage, view in
                
                #warning("TODO: should be defined in the locale system.")
                view.titleLabel.text = NSLocalizedString(
                    "Shipping",
                    comment: ""
                )
                
            },
            for: .header
        )

        template.registerView(
            UICheckoutShippingView.self,
            from: Bundle(for: UICheckoutShippingView.self),
            binding: { storage, view in
                
                view.key = self.key
                
                view.address = storage.address
                
            },
            for: .form
        )
        
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View { return template.view(at: index) }
    
}
