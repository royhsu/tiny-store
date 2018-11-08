//
//  CheckoutItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutItem

public protocol CheckoutItem: Encodable {
    
    var selection: CheckoutItemSelection { get }
    
    var title: CheckoutItemTitle { get }
    
    var description: CheckoutItemDescription { get }
    
    var price: CheckoutItemPrice { get }
    
    var quantity: CheckoutItemQuantity { get }
    
}
