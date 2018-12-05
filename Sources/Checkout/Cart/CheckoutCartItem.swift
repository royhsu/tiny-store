//
//  CheckoutCartItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutCartItem

public protocol CheckoutCartItem {
    
    var isSelected: Content<Bool> { get }
    
    var title: Model<String> { get }
    
    var description: Model<String> { get }
    
    var price: Model<Double> { get }
    
    var quantity: Model<Int> { get }
    
}
