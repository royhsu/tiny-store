//
//  CheckoutRecipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipient

import TinyCore

public final class CheckoutRecipient: Unique {
    
    public final let identifier = UUID()
    
    public final var firstName: String
    
    public init(firstName: String) { self.firstName = firstName }
    
}
