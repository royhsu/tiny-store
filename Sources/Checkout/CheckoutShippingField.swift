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

    /// Default is required.
    public final let city: FormField<City>
    
    /// Default is required.
    public final let address: FormField<String>

    public init(
        style: CheckoutShippingStyle.Type,
        city: FormField<City> = FormField(),
        address: FormField<String> = FormField(
            rules: [ .notEmpty ]
        )
    ) {

        self.style = style

        self.city = city

        self.address = address

    }

}
