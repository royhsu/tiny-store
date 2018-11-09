//
//  Content+Codable.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - Decodable

extension Content: Decodable where Value: Decodable {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        let value = try container.decode(Value.self)
        
        self.init(value: value)
        
    }
    
}

// MARK: - Encodable

extension Content: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        try container.encode(property)
        
    }
    
}
