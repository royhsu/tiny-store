//
//  UICheckoutShippingTemplate.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/25.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutShippingTemplate

public struct UICheckoutShippingTemplate: CheckoutShippingTemplate {
    
    public struct Configuration: TemplateConfiguration {
        
        public typealias Element = UICheckoutShippingTemplateElement
        
    }
    
    private let template: ConfigurableTemplate<CheckoutShippingField, Configuration>
    
    public init(
        field: CheckoutShippingField,
        elements: [Configuration.Element] = [
            .header,
            .form
        ]
    ) {
        
        self.template = ConfigurableTemplate(
            storage: field,
            elements: elements
        )
        
        self.prepare()
        
    }
    
    public init(_ field: CheckoutShippingField) { self.init(field: field) }
    
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
            binding: { shipping, view in view.shipping = shipping },
            for: .form
        )
        
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View { return template.view(at: index) }
    
}
