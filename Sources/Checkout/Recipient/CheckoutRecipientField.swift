//
//  CheckoutRecipientField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientField

public struct CheckoutRecipientField {

    public var firstNameField: CheckoutFirstNameField
    
    public var lastNameField: CheckoutLastNameField
    
    public var personTitleField: CheckoutPersonTitleField
    
    public var phoneNumberField: CheckoutPhoneNumberField

    public init(
        firstNameField: CheckoutFirstNameField = .init(),
        lastNameField: CheckoutLastNameField = .init(),
        personTitleField: CheckoutPersonTitleField = .init(),
        phoneNumberField: CheckoutPhoneNumberField = .init()
    ) {

        self.firstNameField = firstNameField
        
        self.lastNameField = lastNameField
        
        self.personTitleField = personTitleField
        
        self.phoneNumberField = phoneNumberField

    }

}
