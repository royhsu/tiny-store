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

    public final var city: City?

    public final var cityRules: [ AnyValidationRule<City> ]

    public final var address: String?

    public final var addressRules: [ AnyValidationRule<String> ]

    public init(
        style: CheckoutShippingStyle.Type,
        city: City? = nil,
        cityRules: [ AnyValidationRule<City> ] = [
            AnyValidationRule(
                NotNilRule()
            )
        ],
        address: String?,
        addressRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NotNilRule()
            ),
            AnyValidationRule(
                NotEmptyRule()
            )
        ]
    ) {

        self.style = style

        self.city = city

        self.cityRules = cityRules

        self.address = address

        self.addressRules = addressRules

    }

    public final func validate() throws -> CheckoutShippingResult {

        return CheckoutShippingResult(
            identifier: identifier,
            city: try city.explicitlyValidated(by: cityRules),
            address: try address.explicitlyValidated(by: addressRules)
        )

    }

}
