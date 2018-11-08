//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShipping

public struct CheckoutShipping {
    
    public let postalCode: CheckoutPostalCode

    public let city: CheckoutCity
    
    public let address: CheckoutAddress

    public init(
        postalCode: CheckoutPostalCode,
        city: CheckoutCity,
        address: CheckoutAddress
    ) {
        
        self.postalCode = postalCode
        
        self.city = city

        self.address = address

    }

}
