//
//  CheckoutItemStyle.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItemStyle

public protocol CheckoutItemStyle {
    
    static func apply(to field: CheckoutItemField) -> Template
    
}
