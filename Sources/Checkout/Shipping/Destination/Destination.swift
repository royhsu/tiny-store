//
//  Destination.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/11.
//

// MARK: - Destination

public protocol ShippingDestination {
    
    var recipient: ShippingRecipient { get }
    
    var address: ShippingAddress { get }
    
}


public protocol NewShippingDestination: Decodable {
    
    var recipient: NewShippingRecipient { get set }
    
    init(
        recipient: NewShippingRecipient?
    )
    
}

private enum ShippingDestinationCodingKeys: CodingKey {
    
    case recipient
    
}

extension NewShippingDestination {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ShippingDestinationCodingKeys.self)
        
        let recipient = try container.decodeIfPresent(
            DefaultShippingRecipient.self,
            forKey: .recipient
        )
        
        self.init(recipient: recipient)
        
    }
    
}


public struct DefaultShippingDestination: NewShippingDestination {
    
    public var recipient: NewShippingRecipient
    
    public init(
        recipient: NewShippingRecipient? = nil
    ) {
        
        self.recipient = recipient ?? DefaultShippingRecipient()
        
    }
    
}

struct Destination: ShippingDestination {
    
    let recipient: ShippingRecipient
    
    let address: ShippingAddress
    
}
