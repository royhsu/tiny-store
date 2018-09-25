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
        
        case city(String)
        
        case postalCode(String)
        
        case address(String)
        
    }
    
    case newInput(Input)
    
}
