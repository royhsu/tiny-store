//
//  OrderError.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - OrderError

public enum OrderError: Error {
    
    case itemRequired
    
    case cityRequired
    
    case postalCodeRequired
    
    case addressRequired
    
    case firstNameRequired
    
    case lastNameRequired
    
    case phoneNumberRequired
    
}
