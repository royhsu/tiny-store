//
//  UICheckoutItemStyle.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutItemStyle

public struct UICheckoutItemStyle: CheckoutItemStyle {
    
    public static func apply(to field: CheckoutItemField) -> Template { return UICheckoutItemTemplate(field) }
    
}
