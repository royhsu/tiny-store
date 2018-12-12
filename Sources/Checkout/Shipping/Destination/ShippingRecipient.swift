//
//  ShippingRecipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - Recipient

public protocol ShippingRecipient: Decodable {

    var firstName: TSModel<String> { get set }

    var lastName: TSModel<String> { get set }

    init(
        firstName: String?,
        lastName: String?
    )

}

// MARK: - Codable (Default Implementation)

private enum ShippingRecipientCodingKeys: CodingKey {

    case firstName, lastName

}

extension ShippingRecipient {

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: ShippingRecipientCodingKeys.self)

        let firstName = try container.decodeIfPresent(
            String.self,
            forKey: .firstName
        )

        let lastName = try container.decodeIfPresent(
            String.self,
            forKey: .lastName
        )

        self.init(
            firstName: firstName,
            lastName: lastName
        )

    }

}
