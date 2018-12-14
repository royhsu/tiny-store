//
//  DefaultShippingService.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - DefaultShippingService

public struct DefaultShippingService: ShippingService {
    
    public var isSelected: Model<Bool>
    
    public var title: Model<String>
    
    public var price: Model<Double>
    
    public init(
        isSelected: Bool = false,
        title: String,
        price: Double
    ) {
        
        self.isSelected = Model(value: isSelected)
        
        self.title = Model(value: title)
        
        self.price = Model(value: price)
        
    }
    
}
