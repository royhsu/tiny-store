//
//  CheckoutShippingStyle.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutShippingStyle

import TinyKit

public protocol CheckoutShippingStyle {
    
    static func apply(to field: CheckoutShippingField) -> Template
    
}
