//
//  CheckoutRecipientField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientField

public struct CheckoutRecipientField {

    public let identifier: UUID

    public let style: CheckoutRecipientStyle.Type

    public let firstNameField: CheckoutFirstNameField
    
    public let lastNameField: CheckoutLastNameField
    
    public let phoneNumberField: CheckoutPhoneNumberField

    public init(
        identifier: UUID = UUID(),
        style: CheckoutRecipientStyle.Type,
        firstNameField: CheckoutFirstNameField = .init(),
        lastNameField: CheckoutLastNameField = .init(),
        phoneNumberField: CheckoutPhoneNumberField = .init()
    ) {
        
        self.identifier = identifier

        self.style = style

        self.firstNameField = firstNameField
        
        self.lastNameField = lastNameField
        
        self.phoneNumberField = phoneNumberField

    }

}
