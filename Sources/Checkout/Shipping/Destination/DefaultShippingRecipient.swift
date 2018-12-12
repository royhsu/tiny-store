//
//  DefaultShippingRecipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingRecipient

public struct DefaultShippingRecipient: ShippingRecipient {

    public var firstName: TSModel<String>

    public var lastName: TSModel<String>

    public init(
        firstName: String? = nil,
        lastName: String? = nil
    ) {

        self.firstName = TSModel(
            value: firstName,
            rules: [ .nonEmpty ]
        )

        self.lastName = TSModel(
            value: lastName,
            rules: [ .nonEmpty ]
        )

    }

}
