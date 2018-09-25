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
        
        public typealias Element = RecipientElement
        
    }
    
    private let template: ConfigurableTemplate<CheckoutRecipient, Configuration>
    
    public init(
        storage: CheckoutRecipient,
        reducer: (CheckoutRecipient) -> [RecipientElement]
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
    
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View { return template.view(at: index) }
    
}

