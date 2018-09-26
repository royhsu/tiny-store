//
//  CheckoutShipping.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShipping

import TinyCore

public final class CheckoutShipping: Unique {
    
    public final let identifier = UUID()
    
    public final var address: String
    
    public init(address: String) { self.address = address }
    
}
