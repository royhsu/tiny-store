//
//  CheckoutShippingServiceTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/14.
//

// MARK: - CheckoutShippingServiceTemplate

public protocol CheckoutShippingServiceTemplate: Template {
    
    var service: ShippingService { get }
    
}
