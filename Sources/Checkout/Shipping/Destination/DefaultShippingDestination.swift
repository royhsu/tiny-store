//
//  DefaultShippingDestination.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingDestination

public struct DefaultShippingDestination: ShippingDestination {
    
    public var recipient: ShippingRecipient
    
    public init(recipient: ShippingRecipient? = nil) {
        
        self.recipient = recipient ?? DefaultShippingRecipient()
        
    }
    
}
