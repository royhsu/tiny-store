//
//  CheckoutShipping.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShipping

public protocol CheckoutShipping {
    
    #warning("Maybe this is better than key as identifier.")
//    var identifier: UUID { get }
    
    var address: String { get set }
    
}
