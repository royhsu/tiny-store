//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingField

public struct CheckoutShippingField {

    public var cityField: CheckoutCityField
    
    public var postalCodeField: CheckoutPostalCodeField
    
    public var addressField: CheckoutAddressField

    public init(
        cityField: CheckoutCityField = .init(),
        postalCodeField: CheckoutPostalCodeField = .init(),
        addressField: CheckoutAddressField = .init()
    ) {
        
        self.cityField = cityField
        
        self.postalCodeField = postalCodeField

        self.addressField = addressField

    }

}
