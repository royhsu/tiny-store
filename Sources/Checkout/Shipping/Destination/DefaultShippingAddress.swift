//
//  DefaultShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingAddress

public struct DefaultShippingAddress: NewShippingAddress {

    public var postalCode: TSModel<PostalCode>

    public var state: TSModel<AddressState>

    public var line1: TSModel<String>

    public var line2: TSModel<String>

    public init(
        postalCode: PostalCode? = nil,
        state: AddressState? = nil,
        line1: String? = nil,
        line2: String? = nil
    ) {

        self.postalCode = TSModel(value: postalCode)

        self.state = TSModel(value: state)

        self.line1 = TSModel(
            value: line1,
            rules: [ .nonEmpty ]
        )

        self.line2 = TSModel(
            value: line2,
            rules: [ .nonEmpty ],
            isRequired: false
        )

    }

}
