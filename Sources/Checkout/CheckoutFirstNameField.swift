//
//  CheckoutFirstNameField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

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
