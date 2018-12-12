//
//  DefaultShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingAddress

public struct DefaultShippingAddress: ShippingAddress {

    public var postalCode: Model<PostalCode>

    public var state: Model<AddressState>

    public var line1: Model<String>

    public var line2: Model<String>

    public init(
        postalCode: PostalCode? = nil,
        state: AddressState? = nil,
        line1: String? = nil,
        line2: String? = nil
    ) {

        self.postalCode = Model(value: postalCode)

        self.state = Model(value: state)

        self.line1 = Model(
            value: line1,
            rules: [ .nonEmpty ]
        )

        self.line2 = Model(
            value: line2,
            rules: [ .nonEmpty ],
            isRequired: false
        )

    }

}
