//
//  CheckoutCityFieldValue.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutCityFieldValue

public struct CheckoutCityFieldValue {
    
    public typealias Rule = AnyValidationRule<City>
    
    public var rawValue: City?
    
    public var rules: [Rule]
    
    public init(
        rawValue: City? = nil,
        rules: [Rule] = []
    ) {
        
        self.rawValue = rawValue
        
        self.rules = rules
        
    }
    
}
