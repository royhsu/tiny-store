//
//  CheckoutFormResult.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutFormResult

public protocol CheckoutFormResult {
    
    init(_ fields: AnyCollection<CheckoutField>) throws
    
}
