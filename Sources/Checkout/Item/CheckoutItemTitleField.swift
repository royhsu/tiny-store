//
//  CheckoutItemTitleField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemTitleField

public struct CheckoutItemTitleField: Field {
    
    public let title: Observable<String>
    
    public var content: Observable<String> { return title }
    
    public let rules: [AnyValidationRule<String>] = []
    
    public let isRequired = true
    
    public init(title: Observable<String>) { self.title = title }
    
}

public protocol Field: Encodable {
    
    associatedtype Value: Encodable
    
    var content: Observable<Value> { get }
    
    var rules: [AnyValidationRule<Value>] { get }
    
    var isRequired: Bool { get }
    
}

public extension Field {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        if isRequired {
            
            let value = try content.value.explicitlyValidated(
                by: NotNilRule()
            )
            
            try rules.forEach { rule in _ = try rule.validate(value) }
            
            try container.encode(value)
            
        }
        else {
        
            if let value = content.value {
                
                try rules.forEach { rule in _ = try rule.validate(value) }
                
                try container.encode(value)
                
            }
            else { try container.encodeNil() }
            
        }
        
    }
    
}

extension Observable: Decodable where Value: Decodable {
    
    public convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        self.init()
        
        self.value = try container.decode(Value.self)
        
    }
    
}

extension Observable: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        if let value = value {
            
            try container.encode(value)
            
            return
            
        }
        
        try container.encodeNil()
        
    }
    
}
