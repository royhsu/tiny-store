//
//  CheckoutSkirtItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutSkirtItem

public struct CheckoutSkirtItem: CheckoutItem {
    
    public let isSelected: Content<Bool>
    
    public let title: Content<String>
    
    private let _description: String
    
    public var description: Content<String> { return Content(value: _description) }
    
    public let color: Content<String>
    
    public let size: Content<String>
    
    public let price: Content<Double>
    
    public let quantity: Content<Int>
    
    public let style: CheckoutItemTemplate.Type
    
    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int,
        style: CheckoutItemTemplate.Type
    ) {
        
        self.isSelected = Content(value: isSelected)
        
        self.title = Content(value: title)
        
        self._description = "\(color) - \(size)"
        
        self.color = Content(value: color)
        
        self.size = Content(value: size)
        
        self.price = Content(value: price)
        
        self.quantity = Content(value: quantity)
        
        self.style = style
        
    }
    
}
