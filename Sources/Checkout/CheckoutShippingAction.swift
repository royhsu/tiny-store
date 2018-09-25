//
//  CheckoutShippingAction.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingAction

import TinyKit

public enum CheckoutShippingAction: Action {
    
    public enum Input {
        
        case city(key: Int, value: String)
        
        case postalCode(key: Int, value: String)
        
        case address(key: Int, value: String)
        
    }
    
    case newInput(Input)
    
}
