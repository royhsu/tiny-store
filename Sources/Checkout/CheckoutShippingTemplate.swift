//
//  CheckoutShippingTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingTemplate

import TinyKit

public protocol CheckoutShippingTemplate: Template {
    
    init(_ field: CheckoutShippingField)
    
}
