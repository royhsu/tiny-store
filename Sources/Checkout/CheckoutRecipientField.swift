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

    public final let firstName: CheckoutFirstNameField
    
    public final let lastName: CheckoutLastNameField
    
    public final let phoneNumber: CheckoutPhoneNumberField

    public init(
        style: CheckoutRecipientStyle.Type,
        firstName: CheckoutFirstNameField = .init(),
        lastName: CheckoutLastNameField = .init(),
        phoneNumber: CheckoutPhoneNumberField = .init()
    ) {

        self.style = style

        self.firstName = firstName
        
        self.lastName = lastName
        
        self.phoneNumber = phoneNumber

    }

}

// MARK: - CheckoutFirstNameField

public final class CheckoutFirstNameField: FormField<String> {
    
    public override init(
        value: String? = nil,
        rules: [Rule] = [ .notEmpty ],
        definition: FormFieldDefinition = .required
    ) {
        
        super.init(
            value: value,
            rules: rules,
            definition: definition
        )
        
    }
    
}

// MARK: - CheckoutLastNameField

public final class CheckoutLastNameField: FormField<String> {
    
    public override init(
        value: String? = nil,
        rules: [Rule] = [ .notEmpty ],
        definition: FormFieldDefinition = .required
    ) {
        
        super.init(
            value: value,
            rules: rules,
            definition: definition
        )
        
    }
    
}

// MARK: - CheckoutPhoneNumberField

public final class CheckoutPhoneNumberField: FormField<String> {
    
    public override init(
        value: String? = nil,
        rules: [Rule] = [ .notEmpty ],
        definition: FormFieldDefinition = .required
    ) {
        
        super.init(
            value: value,
            rules: rules,
            definition: definition
        )
        
    }
    
}
