//
//  ShippingDestination.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - Destination

public protocol ShippingDestination: Decodable {
    
    var recipient: ShippingRecipient { get set }
    
    init(recipient: ShippingRecipient?)
    
}

// MARK: - Codable (Default Implementation)

private enum ShippingDestinationCodingKeys: CodingKey {
    
    case recipient
    
}

public extension ShippingDestination {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ShippingDestinationCodingKeys.self)
        
        let recipient = try container.decodeIfPresent(
            DefaultShippingRecipient.self,
            forKey: .recipient
        )
        
        self.init(recipient: recipient)
        
    }
    
}
