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

    public final let firstNameDefinition: FormFieldDefinition<String>
    
    public final var lastName: String?
    
    public final var lastNameRules: [ AnyValidationRule<String> ]
    
    public final var phoneNumber: String?
    
    public final var phoneNumberRules: [ AnyValidationRule<String> ]

    public init(
        style: CheckoutRecipientStyle.Type,
        firstNameDefinition: FormFieldDefinition<String> = .required(
            FormField(
                rules: [ .notEmpty ]
            )
        ),
        lastName: String? = nil,
        lastNameRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NotEmptyRule<String>()
            )
        ],
        phoneNumber: String? = nil,
        phoneNumberRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NotEmptyRule<String>()
            )
        ]
    ) {

        self.style = style

        self.firstNameDefinition = firstNameDefinition
        
        self.lastName = lastName
        
        self.lastNameRules = lastNameRules
        
        self.phoneNumber = phoneNumber
        
        self.phoneNumberRules = phoneNumberRules

    }

//    public func validate() throws -> CheckoutRecipientResult {

//        return CheckoutRecipientResult(
//            identifier: identifier,
//            firstName: try firstName.explicitlyValidated(by: firstNameRules),
//            lastName: try lastName.explicitlyValidated(by: lastNameRules),
//            phoneNumber: try phoneNumber.explicitlyValidated(by: phoneNumberRules)
//        )

//    }

}
