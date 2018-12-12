//
//  DefaultShippingRecipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingRecipient

public struct DefaultShippingRecipient: ShippingRecipient {

    public var firstName: Model<String>

    public var lastName: Model<String>

    public init(
        firstName: String? = nil,
        lastName: String? = nil
    ) {

        self.firstName = Model(
            value: firstName,
            rules: [ .nonEmpty ]
        )

        self.lastName = Model(
            value: lastName,
            rules: [ .nonEmpty ]
        )

    }

}
