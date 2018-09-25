//
//  CheckoutRecipientTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientTemplate

import TinyKit

public protocol CheckoutRecipientTemplate: Template {
    
    typealias Element = CheckoutRecipientTemplateElement
    
    init(
        storage: CheckoutRecipient,
        reducer: (CheckoutRecipient) -> [Element]
    )
    
}
