//
//  CheckoutRecipientAction.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutRecipientAction

public enum CheckoutRecipientAction: Action {
    
    case updateValue(CheckoutRecipientField)
    
    case showPersonTitlePicker(CheckoutRecipientField)
    
}
