//
//  CartItemController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CartItemController

public protocol CartItemController: AnyObject {
    
    var item: CartItem? { get set }
    
}
