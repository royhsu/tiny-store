//
//  CheckoutItemPriceField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemPriceField

public struct CheckoutItemPriceField {
    
    public let price: Observable<Double>
    
    public init(price: Observable<Double>) { self.price = price }
    
}
