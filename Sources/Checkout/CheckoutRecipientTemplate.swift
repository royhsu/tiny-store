//
//  CheckoutRecipientTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientTemplate

import TinyKit

public protocol CheckoutRecipientTemplate: Template {
    
    init(
        storage: CheckoutRecipient,
        reducer: (CheckoutRecipient) -> [RecipientElement]
    )
    
}
