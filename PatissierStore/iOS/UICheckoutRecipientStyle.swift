//
//  UICheckoutRecipientStyle.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/27.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutRecipientStyle

public struct UICheckoutRecipientStyle: CheckoutRecipientStyle {
    
    public static func apply(to field: CheckoutRecipientField) -> Template { return UICheckoutRecipientTemplate(field) }
    
}
