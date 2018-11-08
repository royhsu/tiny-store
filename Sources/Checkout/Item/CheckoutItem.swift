//
//  CheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItem

public protocol CheckoutItem: Encodable {
    
    var selection: CheckoutSelection { get }
    
    var title: CheckoutItemTitle { get }
    
    var description: CheckoutItemDescription { get }
    
    var price: CheckoutItemPrice { get }
    
    var quantity: CheckoutItemQuantity { get }
    
}

public protocol NewCheckoutItem {
    
    var isSelected: NewContent<Bool> { get }
    
    var title: NewContent<String> { get }
    
    var description: NewContent<String> { get }
    
    var price: NewContent<Double> { get }
    
    var quantity: NewContent<Int> { get }
    
}
