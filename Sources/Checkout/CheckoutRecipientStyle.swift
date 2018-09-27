//
//  CheckoutRecipientStyle.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutRecipientStyle

import TinyKit

public protocol CheckoutRecipientStyle {
    
    static func apply(to field: CheckoutRecipientField) -> Template
    
}
