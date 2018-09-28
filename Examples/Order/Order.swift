//
//  Order.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Order

import TinyStore

public struct Order: CheckoutOrder {
    
    public let items: [OrderItem]
    
    public let city: City
    
    public let postalCode: String
    
    public let address: String
    
    public let firstName: String
    
    public let lastName: String
    
    public let phoneNumber: String
    
    public init(_ fields: AnyCollection<CheckoutField>) throws {
        
        var items: [OrderItem] = []
        
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
                    OrderItem(quantity: field.quantity)
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
        
        if items.isEmpty { throw OrderError.itemRequired }
        else { self.items = items }
        
        if let city = city { self.city = city }
        else { throw OrderError.cityRequired }
        
        if let postalCode = postalCode { self.postalCode = postalCode }
        else { throw OrderError.postalCodeRequired }
        
        if let address = address { self.address = address }
        else { throw OrderError.addressRequired }
        
        if let firstName = firstName { self.firstName = firstName }
        else { throw OrderError.firstNameRequired }
        
        if let lastName = lastName { self.lastName = lastName }
        else { throw OrderError.lastNameRequired }
        
        if let phoneNumber = phoneNumber { self.phoneNumber = phoneNumber }
        else { throw OrderError.phoneNumberRequired }
        
    }
    
}
