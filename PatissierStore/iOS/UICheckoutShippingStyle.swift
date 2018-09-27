//
//  UICheckoutShippingStyle.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/27.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutShippingStyle

import TinyKit

public struct UICheckoutShippingStyle: CheckoutShippingStyle {
    
    public static func apply(to field: CheckoutShippingField) -> Template { return UICheckoutShippingTemplate(field) }
    
}
