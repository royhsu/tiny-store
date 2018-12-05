//
//  CheckoutApparelItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutApparelItem

public final class CheckoutApparelItem: CheckoutCartItem {
    
    private final var observations: [Observation] = []
    
    public final let isSelected: Content<Bool>
    
    public final let title: Model<String>
    
    public final let description: Model<String>
    
    public final let color: Model<String>
    
    public final let size: Model<String>
    
    public final let price: Content<Double>
    
    public final let quantity: Model<Int>
    
    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int
    ) {
        
        self.isSelected = Content(value: isSelected)
        
        self.title = Model(value: title)
        
        self.description = Model(value: "\(color) - \(size)")
        
        self.color = Model(value: color)
        
        self.size = Model(value: size)
        
        self.price = Content(value: price)
        
        self.quantity = Model(value: quantity)
        
        self.load()
        
    }
    
    private final func load() {
        
        observations = [
            color.observe { [weak self] _ in
                
                guard
                    let self = self,
                    let color = self.color.value,
                    let size = self.size.value
                else { return }
                
                self.description.value = "\(color) - \(size)"
                
            },
            size.observe { [weak self] _ in
                
                guard
                    let self = self,
                    let color = self.color.value,
                    let size = self.size.value
                else { return }
                
                self.description.value = "\(color) - \(size)"
                
            }
        ]
        
    }
    
}
