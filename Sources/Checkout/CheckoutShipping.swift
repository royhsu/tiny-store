//
//  CheckoutShipping.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/25.
//

// MARK: - CheckoutShipping

//public protocol CheckoutShipping {

    #warning("Maybe this is better than key as identifier.")
//    var identifier: UUID { get }
    
//    var address: CheckoutShippingAddress { get set }
//
//}

public struct CheckoutShippingAddress {

    public let identifier: Int

    public var text: String
    
    public var isFirstResponder: Bool
    
    public init(
        identifier: Int,
        text: String,
        isFirstResponder: Bool
    ) {
        
        self.identifier = identifier
        
        self.text = text
        
        self.isFirstResponder = isFirstResponder
        
    }

}

public enum CheckoutShipping {
    
    case address(CheckoutShippingAddress)
    
}
