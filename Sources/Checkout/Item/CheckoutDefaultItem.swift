//
//  CheckoutDefaultItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutDefaultItem

public struct CheckoutSkirtItem: NewCheckoutItem {
    
    public let isSelected: NewContent<Bool>
    
    public let title: NewContent<String>
    
    private let _description: String
    
    public var description: NewContent<String> { return NewContent(value: _description) }
    
    public let color: NewContent<String>
    
    public let size: NewContent<String>
    
    public let price: NewContent<Double>
    
    public let quantity: NewContent<Int>
    
    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int
    ) {
        
        self.isSelected = NewContent(value: isSelected)
        
        self.title = NewContent(value: title)
        
        self._description = "\(color) - \(size)"
        
        self.color = NewContent(value: color)
        
        self.size = NewContent(value: size)
        
        self.price = NewContent(value: price)
        
        self.quantity = NewContent(value: quantity)
        
    }
    
}

public struct CheckoutDefaultItem: CheckoutItem {
    
    private enum CodingKeys: String, CodingKey {
        
        case title = "title"
        
        case color = "color"
        
        case price = "price"
        
        case quantity = "quantity"
        
    }
    
    public let selection: CheckoutSelection
    
    public let title: CheckoutItemTitle
    
    public let description: CheckoutItemDescription
    
    public let color: CheckoutItemColor
    
    public let price: CheckoutItemPrice
    
    public let quantity: CheckoutItemQuantity
    
    public init(
        selection: CheckoutSelection,
        title: CheckoutItemTitle,
        description: CheckoutItemDescription,
        color: CheckoutItemColor,
        price: CheckoutItemPrice,
        quantity: CheckoutItemQuantity
    ) {
        
        self.selection = selection
        
        self.title = title
        
        self.description = description
        
        self.color = color
        
        self.price = price
        
        self.quantity = quantity
        
    }
    
}
