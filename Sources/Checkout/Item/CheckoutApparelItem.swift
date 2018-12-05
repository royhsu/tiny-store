//
//  CheckoutApparelItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutApparelItem

public struct CheckoutApparelItem: CheckoutCartItem {
    
    public let isSelected: Content<Bool>
    
    public let title: AnyObservable<String>
    
    private let _description: String
    
    public var description: Content<String> { return Content(value: _description) }
    
    public let color: Content<String>
    
    public let size: Content<String>
    
    public let price: Content<Double>
    
    public let quantity: Content<Int>
    
    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int
    ) {
        
        self.isSelected = Content(value: isSelected)
        
        self.title = AnyObservable(
            Model(value: title)
        )
        
        self._description = "\(color) - \(size)"
        
        self.color = Content(value: color)
        
        self.size = Content(value: size)
        
        self.price = Content(value: price)
        
        self.quantity = Content(value: quantity)
        
    }
    
}
