//
//  CheckoutField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutField

public enum CheckoutField: Unique {

    case shipping(CheckoutShippingField)

    case recipient(CheckoutRecipientField)

    public var identifier: UUID {

        switch self {

        case let .shipping(field): return field.identifier

        case let .recipient(field): return field.identifier

        }

    }

    public func validate() throws -> CheckoutResult {

        switch self {

        case let .shipping(field):

            return .shipping(
                try field.validate()
            )

        case let .recipient(field):

            return .recipient(
                try field.validate()
            )

        }

    }

}

public enum CheckoutResult {

    case shipping(CheckoutShippingResult)

    case recipient(CheckoutRecipientResult)

}

#warning("the current implementation doesn't allow optional field results.")
public struct CheckoutShippingResult {

    public let identifier: UUID

    public let city: City

    public let address: String

    public init(
        identifier: UUID,
        city: City,
        address: String
    ) {

        self.identifier = identifier

        self.city = city

        self.address = address

    }

}

#warning("the current implementation doesn't allow optional field results.")
public struct CheckoutRecipientResult {

    public let identifier: UUID

    public let firstName: String
    
    public let lastName: String
    
    public let phoneNumber: String

    public init(
        identifier: UUID,
        firstName: String,
        lastName: String,
        phoneNumber: String
    ) {

        self.identifier = identifier

        self.firstName = firstName
        
        self.lastName = lastName
        
        self.phoneNumber = phoneNumber

    }

}
