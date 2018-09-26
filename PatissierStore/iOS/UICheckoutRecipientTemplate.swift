//
//  UICheckoutRecipientTemplate.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/25.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutRecipientTemplate

import TinyKit
import TinyStore

public struct UICheckoutRecipientTemplate: CheckoutRecipientTemplate {
    
    public struct Configuration: TemplateConfiguration {
        
        public typealias Element = CheckoutRecipientTemplate.Element
        
    }
    
    private let template: ConfigurableTemplate<CheckoutRecipientField, Configuration>
    
    public init(
        storage: CheckoutRecipientField,
        reducer: (CheckoutRecipientField) -> [Element]
    ) {
        
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
                    "Recipient",
                    comment: ""
                )

            },
            for: .header
        )
        
        template.registerView(
            UICheckoutRecipientView.self,
            from: Bundle(for: UICheckoutRecipientView.self),
            binding: { recipient, view in view.recipient = recipient },
            for: .form
        )
    
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View { return template.view(at: index) }
    
}

