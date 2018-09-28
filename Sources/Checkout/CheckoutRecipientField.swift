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

    /// Default is required.
    public final let firstName: FormField<String>
    
    /// Default is required.
    public final let lastName: FormField<String>
    
    /// Default is required.
    public final let phoneNumber: FormField<String>

    public init(
        style: CheckoutRecipientStyle.Type,
        firstName: FormField<String> = FormField(
            rules: [ .notEmpty ]
        ),
        lastName: FormField<String> = FormField(
            rules: [ .notEmpty ]
        ),
        phoneNumber: FormField<String> = FormField(
            rules: [ .notEmpty ]
        )
    ) {

        self.style = style

        self.firstName = firstName
        
        self.lastName = lastName
        
        self.phoneNumber = phoneNumber

    }

}
