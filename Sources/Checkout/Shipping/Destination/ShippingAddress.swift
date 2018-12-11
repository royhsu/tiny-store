//
//  ShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - ShippingAddress

public protocol NewShippingAddress {

    // title
    
    var postalCode: TSModel<PostalCode> { get set }

    // country

    var state: TSModel<AddressState> { get set }

    // city

    var line1: TSModel<String> { get set }
    
    var line2: TSModel<String> { get set }
    
}
