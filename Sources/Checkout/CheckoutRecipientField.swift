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
    
    public final var firstName: String
    
    public final var firstNameRules: [ AnyValidationRule<String> ]
    
    public init(
        style: CheckoutRecipientStyle.Type,
        firstName: String,
        firstNameRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NonEmptyRule<String>()
            )
        ]
    ) {
        
        self.style = style
        
        self.firstName = firstName
        
        self.firstNameRules = firstNameRules
        
    }
    
    public func validate() throws -> CheckoutRecipientResult {
        
        return CheckoutRecipientResult(
            identifier: identifier,
            firstName: try firstName.validated(by: firstNameRules)
        )
        
    }
    
}
