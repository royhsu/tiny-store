//
//  CheckoutItemTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CheckoutItemTemplate

public protocol CheckoutItemTemplate: Template {
    
    var isSeparatorHidden: Bool { get set }
    
    init(item: CheckoutItem)
    
}
