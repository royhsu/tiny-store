//
//  Apparel.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - Apparel

public final class Apparel: CartItem {
    
    public final var isSelected: TSModel<Bool>
    
    public final var title: TSModel<String>
    
    public final var description = TSModel<String>()
    
    private final var colorObservation: Observation?
    
    public final var color: TSModel<String> {
        
        didSet {
            
            colorObservation = color.addObserver(self) { [weak self] _, _ in self?.description.value = self?.itemDescription }
            
        }
        
    }
    
    private final var sizeObservation: Observation?
    
    public final var size: TSModel<String> {
        
        didSet {
            
            sizeObservation = size.addObserver(self) { [weak self] _, _ in self?.description.value = self?.itemDescription }
            
        }
        
    }
    
    public final var price: TSModel<Double>
    
    public final var quantity: TSModel<Int>
    
    public init(
        isSelected: Bool,
        title: String,
        color: String,
        size: String,
        price: Double,
        quantity: Int
    ) {
        
        self.isSelected = TSModel(value: isSelected)
        
        self.title = TSModel(value: title)
        
        self.color = TSModel(value: color)
        
        self.size = TSModel(value: size)
        
        self.price = TSModel(value: price)
        
        self.quantity = TSModel(value: quantity)
        
        self.load()
        
    }
    
    private final func load() {
        
        description.value = itemDescription
        
        colorObservation = color.addObserver(self) { [weak self] _, _ in self?.description.value = self?.itemDescription }
        
        sizeObservation = size.addObserver(self) { [weak self] _, _ in self?.description.value = self?.itemDescription }
        
    }
    
    private final var itemDescription: String? {
        
        guard
            let color = self.color.value,
            let size = self.size.value
        else { return nil }
        
        return "\(color) - \(size)"
        
    }
    
}
