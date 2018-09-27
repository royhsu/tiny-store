//
//  CheckoutShippingField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: = CheckoutShippingField

public final class CheckoutShippingField: Unique {

    public final let identifier = UUID()

    public final let style: CheckoutShippingStyle.Type

    public typealias City = CheckoutCityFieldValue

    /// Default is required.
    public final var city: City?
    
    public typealias Address = CheckoutAddressFieldValue
    
    /// Default is required.
    public final var address: Address?

    public init(
        style: CheckoutShippingStyle.Type,
        city: City? = City(),
        address: Address? = Address()
    ) {

        self.style = style

        self.city = city

        self.address = address

    }

}
