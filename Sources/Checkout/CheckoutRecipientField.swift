//
//  CheckoutRecipientField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientField

public final class CheckoutRecipientField: Unique {

    public final let identifier = UUID()

    public final let style: CheckoutRecipientStyle.Type

    public final let firstNameField: CheckoutFirstNameField
    
    public final let lastNameField: CheckoutLastNameField
    
    public final let phoneNumberField: CheckoutPhoneNumberField

    public init(
        style: CheckoutRecipientStyle.Type,
        firstNameField: CheckoutFirstNameField = .init(),
        lastNameField: CheckoutLastNameField = .init(),
        phoneNumberField: CheckoutPhoneNumberField = .init()
    ) {

        self.style = style

        self.firstNameField = firstNameField
        
        self.lastNameField = lastNameField
        
        self.phoneNumberField = phoneNumberField

    }

}
