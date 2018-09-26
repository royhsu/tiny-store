//
//  CheckoutRecipientField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutRecipientField

import TinyCore
import TinyValidation

public final class CheckoutRecipientField: Unique {
    
    public final let identifier = UUID()
    
    public final var firstName: String
    
    public final var firstNameRules: [ AnyValidationRule<String> ]
    
    public init(
        firstName: String,
        firstNameRules: [ AnyValidationRule<String> ] = [
            AnyValidationRule(
                NonEmptyRule<String>()
            )
        ]
    ) {
        
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
