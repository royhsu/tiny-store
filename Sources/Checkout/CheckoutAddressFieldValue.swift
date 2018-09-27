//
//  CheckoutAddressFieldValue.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutAddressFieldValue

public struct CheckoutAddressFieldValue: CheckoutFieldValue {
    
    public typealias Rule = AnyValidationRule<String>
    
    public var rawValue: String?
    
    public var rules: [Rule]
    
    public init(
        rawValue: String? = nil,
        rules: [Rule] = [ .notEmpty ]
    ) {
        
        self.rawValue = rawValue
        
        self.rules = rules
        
    }
    
}
