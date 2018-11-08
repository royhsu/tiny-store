//
//  CheckoutRecipient.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipient

public struct CheckoutRecipient {

    public var phoneNumber: CheckoutPhoneNumber

    public init(
        phoneNumber: CheckoutPhoneNumber
    ) { self.phoneNumber = phoneNumber }

}
