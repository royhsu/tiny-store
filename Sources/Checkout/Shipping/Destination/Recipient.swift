//
//  Recipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - Recipient

public protocol ShippingRecipient {
    
    var name: Content<String> { get }
    
}

struct Recipient: ShippingRecipient {
    
    let name: Content<String>
    
    init(name: String) { self.name = Content(value: name) }
    
}

