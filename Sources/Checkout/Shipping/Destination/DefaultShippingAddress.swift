//
//  DefaultShippingAddress.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - DefaultShippingAddress

public struct DefaultShippingAddress: ShippingAddress {

    public var title: Model<String>
    
    public var country: Model<Country>
    
    public var postalCode: Model<PostalCode>
    
    public var state: Model<AddressState>
    
    public var city: Model<City>

    public var line1: Model<String>

    public var line2: Model<String>

    public init(
        title: String? = nil,
        country: Country? = nil,
        postalCode: PostalCode? = nil,
        state: AddressState? = nil,
        city: City? = nil,
        line1: String? = nil,
        line2: String? = nil
    ) {
        
        self.title = Model(value: title)

        self.country = Model(value: country)
        
        self.postalCode = Model(value: postalCode)

        self.state = Model(value: state)

        self.city = Model(value: city)
        
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
