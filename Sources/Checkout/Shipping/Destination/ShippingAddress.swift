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
    
    var state: Model<AddressState> { get set }

    var city: Model<City> { get set }
    
    var district: Model<District> { get set }

    var street1: Model<String> { get set }

    var street2: Model<String> { get set }

}
