//
//  CheckoutOrder.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutOrder

public protocol CheckoutOrder {
    
    init(_ fields: AnyCollection<CheckoutField>) throws
    
}
