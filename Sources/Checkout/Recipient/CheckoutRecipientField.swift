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

    public var firstNameField: CheckoutFirstNameField
    
    public var lastNameField: CheckoutLastNameField
    
    public var personTitleField: CheckoutPersonTitleField
    
    public var phoneNumberField: CheckoutPhoneNumberField

    public init(
        identifier: UUID = UUID(),
        style: CheckoutRecipientStyle.Type,
        firstNameField: CheckoutFirstNameField = .init(),
        lastNameField: CheckoutLastNameField = .init(),
        personTitleField: CheckoutPersonTitleField = .init(),
        phoneNumberField: CheckoutPhoneNumberField = .init()
    ) {
        
        self.identifier = identifier

        self.style = style

        self.firstNameField = firstNameField
        
        self.lastNameField = lastNameField
        
        self.personTitleField = personTitleField
        
        self.phoneNumberField = phoneNumberField

    }

}
