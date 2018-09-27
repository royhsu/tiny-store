//
//  CheckoutShippingTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingTemplate

import TinyKit

public protocol CheckoutShippingTemplate: Template {
    
    typealias Element = CheckoutShippingTemplateElement
    
    init(
        storage: CheckoutShippingField,
        elements: [Element]
    )
    
}

public protocol CheckoutShippingStyle {
    
    static func apply(to field: CheckoutShippingField) -> Template
    
}
