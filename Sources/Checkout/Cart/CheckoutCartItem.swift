//
//  CheckoutCartItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutCartItem

public protocol CheckoutCartItem {
    
    var isSelected: Content<Bool> { get }
    
    var title: AnyObservable<String> { get }
    
    var description: Content<String> { get }
    
    var price: Content<Double> { get }
    
    var quantity: Content<Int> { get }
    
}
