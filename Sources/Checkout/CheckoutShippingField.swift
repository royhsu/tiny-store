//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShippingField

public final class CheckoutShippingField: Unique {

    public final let identifier = UUID()

    public final let style: CheckoutShippingStyle.Type

    public final let cityField: CheckoutCityField
    
    public final let postalCodeField: CheckoutPostalCodeField
    
    public final let addressField: CheckoutAddressField

    public init(
        style: CheckoutShippingStyle.Type,
        cityField: CheckoutCityField = .init(),
        postalCodeField: CheckoutPostalCodeField = .init(),
        addressField: CheckoutAddressField = .init()
    ) {

        self.style = style

        self.cityField = cityField
        
        self.postalCodeField = postalCodeField

        self.addressField = addressField

    }

}
