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
    
    public init(title: Observable<String>) { self.title = title }
    
}

public protocol Field: Encodable {
    
    associatedtype Value: Encodable
    
    var content: Observable<Value> { get }
    
}

public extension Field {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        if let value = content.value {
            
            try container.encode(value)
            
            return
            
        }
        
        try container.encodeNil()
        
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
