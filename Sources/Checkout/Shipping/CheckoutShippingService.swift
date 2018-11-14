//
//  CheckoutShippingService.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - CheckoutShippingService

public protocol CheckoutShippingService {
    
    var isSelected: Content<Bool> { get }
    
    var title: Content<String> { get }
    
    var price: Content<Double> { get }
    
}
