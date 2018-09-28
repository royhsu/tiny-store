//
//  CheckoutResult.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CheckoutResult

import TinyStore

public enum CheckoutResultError: Error {
    
    case itemRequired
    
    case cityRequired
    
    case postalCodeRequired
    
    case addressRequired
    
    case firstNameRequired
    
    case lastNameRequired
    
    case phoneNumberRequired
    
}

public struct CheckoutItem {
    
    public let quantity: UInt
    
    public init(quantity: UInt) { self.quantity = quantity }
    
}

public struct CheckoutResult: CheckoutFormResult {
    
    public let items: [CheckoutItem]
    
    public let city: City
    
    public let postalCode: String
    
    public let address: String
    
    public let firstName: String
    
    public let lastName: String
    
    public let phoneNumber: String
    
    public init(_ fields: AnyCollection<CheckoutField>) throws {
        
        var items: [CheckoutItem] = []
        
        var city: City?
        
        var address: String?
        
        var postalCode: String?
        
        var firstName: String?
        
        var lastName: String?
        
        var phoneNumber: String?
        
        for field in fields {
            
            switch field {
                
            case let .item(field):
                
                items.append(
                    CheckoutItem(quantity: field.quantity)
                )
                
            case let .shipping(field):
                
                city = try field.cityField.validate()
                
                postalCode = try field.postalCodeField.validate()
                
                address = try field.addressField.validate()
                
            case let .recipient(field):
                
                firstName = try field.firstNameField.validate()
                
                lastName = try field.lastNameField.validate()
                
                phoneNumber = try field.phoneNumberField.validate()
                
            }
            
        }
        
        if items.isEmpty { throw CheckoutResultError.itemRequired }
        else { self.items = items }
        
        if let city = city { self.city = city }
        else { throw CheckoutResultError.cityRequired }
        
        if let postalCode = postalCode { self.postalCode = postalCode }
        else { throw CheckoutResultError.postalCodeRequired }
        
        if let address = address { self.address = address }
        else { throw CheckoutResultError.addressRequired }
        
        if let firstName = firstName { self.firstName = firstName }
        else { throw CheckoutResultError.firstNameRequired }
        
        if let lastName = lastName { self.lastName = lastName }
        else { throw CheckoutResultError.lastNameRequired }
        
        if let phoneNumber = phoneNumber { self.phoneNumber = phoneNumber }
        else { throw CheckoutResultError.phoneNumberRequired }
        
    }
    
}
