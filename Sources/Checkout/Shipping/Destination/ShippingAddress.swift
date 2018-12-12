//
//  ShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - ShippingAddress

public protocol ShippingAddress {

    // title

    var postalCode: Model<PostalCode> { get set }

    // country

    var state: Model<AddressState> { get set }

    // city

    var line1: Model<String> { get set }

    var line2: Model<String> { get set }

}
