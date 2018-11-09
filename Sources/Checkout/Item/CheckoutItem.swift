//
//  CheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItem

public protocol CheckoutItem {
    
    var isSelected: Content<Bool> { get }
    
    var title: Content<String> { get }
    
    var description: Content<String> { get }
    
    var price: Content<Double> { get }
    
    var quantity: Content<Int> { get }
    
    var template: CheckoutItemTemplate.Type { get }
    
}
