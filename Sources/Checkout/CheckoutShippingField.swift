//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingField

public struct CheckoutShippingField {

    public let identifier: UUID

    public let style: CheckoutShippingStyle.Type

    public var cityField: NewCheckoutCityField
    
    public let postalCodeField: CheckoutPostalCodeField
    
    public let addressField: CheckoutAddressField

    public init(
        identifier: UUID = UUID(),
        style: CheckoutShippingStyle.Type,
        cityField: NewCheckoutCityField = .init(),
        postalCodeField: CheckoutPostalCodeField = .init(),
        addressField: CheckoutAddressField = .init()
    ) {

        self.identifier = identifier
        
        self.style = style

        self.cityField = cityField
        
        self.postalCodeField = postalCodeField

        self.addressField = addressField

    }

}
