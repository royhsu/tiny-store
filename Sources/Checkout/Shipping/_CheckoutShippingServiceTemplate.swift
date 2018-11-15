//
//  CheckoutShippingServiceTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/14.
//

// MARK: - CheckoutShippingServiceTemplate

@available(*, deprecated: 1.0)
public protocol CheckoutShippingServiceTemplate: Template {
    
    var service: ShippingService { get }
    
}
