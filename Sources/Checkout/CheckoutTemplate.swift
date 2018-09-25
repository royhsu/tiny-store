//
//  CheckoutTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutTemplate

import TinyKit

public enum CheckoutTemplate: Template {
    
    case shipping(CheckoutShippingTemplate)
    
    case recipient(CheckoutRecipientTemplate)
    
    public var template: Template {
        
        switch self {
            
        case let .shipping(template): return template
            
        case let .recipient(template): return template
            
        }
        
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View {  return template.view(at: index) }
    
}
