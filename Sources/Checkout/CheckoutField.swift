//
//  CheckoutField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutField

public enum CheckoutField: TemplateRepresentable {

    case shipping(CheckoutShippingField)

    case recipient(CheckoutRecipientField)

    public var identifier: UUID {

        switch self {

        case let .shipping(field): return field.identifier

        case let .recipient(field): return field.identifier

        }

    }
    
    public var template: Template {
        
        switch self {
            
        case let .shipping(field): return field.style.apply(to: field)
            
        case let .recipient(field): return field.style.apply(to: field)
            
        }
        
    }

}
