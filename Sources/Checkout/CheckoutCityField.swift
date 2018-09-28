//
//  CheckoutCityField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutCityField

public final class CheckoutCityField: FormField<City> {
    
    public override init(
        value: City? = nil,
        rules: [Rule] = [],
        definition: FormFieldDefinition = .required
    ) {
        
        super.init(
            value: value,
            rules: rules,
            definition: definition
        )
        
    }
    
}
