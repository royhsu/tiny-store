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
    
    public var state: Model<AddressState>
    
    public var city: Model<City>
    
    public var district: Model<District>
    
    public var street1: Model<String>

    public var street2: Model<String>

    public init(
        title: String? = nil,
        country: Country? = nil,
        state: AddressState? = nil,
        city: City? = nil,
        district: District? = nil,
        street1: String? = nil,
        street2: String? = nil
    ) {
        
        self.title = Model(value: title)

        self.country = Model(value: country)
        
        self.state = Model(value: state)

        self.city = Model(value: city)
        
        self.district = Model(value: district)

        self.street1 = Model(
            value: street1,
            rules: [ .nonEmpty ]
        )

        self.street2 = Model(
            value: street2,
            rules: [ .nonEmpty ],
            isRequired: false
        )

    }

}
