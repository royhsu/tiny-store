//
//  CartItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CartItem

public protocol CartItem {
    
    var isSelected: TSModel<Bool> { get set }
    
    var title: TSModel<String> { get set }
    
    var description: TSModel<String> { get set }
    
    var price: TSModel<Double> { get set }
    
    var quantity: TSModel<Int> { get set }
    
}
