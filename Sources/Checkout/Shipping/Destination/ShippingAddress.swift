//
//  ShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - ShippingAddress

public protocol ShippingAddress {

    var title: Model<String> { get set }

    var country: Model<Country> { get set }
    
    var postalCode: Model<PostalCode> { get set }

    var state: Model<AddressState> { get set }

    var city: Model<City> { get set }

    var line1: Model<String> { get set }

    var line2: Model<String> { get set }

}
