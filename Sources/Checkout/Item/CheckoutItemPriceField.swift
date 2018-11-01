//
//  CheckoutItemPriceField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemPriceField

public struct CheckoutItemPriceField: Field {
    
    public let price: Observable<Double>
    
    public var content: Observable<Double> { return price }
    
    #warning("add validation rules.")
    public let rules: [AnyValidationRule<Double>] = []
    
    public init(price: Observable<Double>) { self.price = price }
    
}
