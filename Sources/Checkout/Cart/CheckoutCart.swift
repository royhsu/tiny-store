//
//  CheckoutCart.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CheckoutCart

public final class CheckoutCart: DSL {
    
    public enum Element: ViewCollection {
        
        case item(CartItemController & ViewController)
        
        public var numberOfViews: Int {
            
            switch self {
                
            case .item: return 1
                
            }
            
        }
        
        public func view(at index: Int) -> View {
            
            switch self {
                
            case let .item(controller): return controller.view
                
            }
            
        }
        
    }
    
    fileprivate final var isPrepared = false
    
    public final var elements: [Element] {
        
        willSet { observations = [] }
        
        didSet {
            
            guard isPrepared else { return }
            
            handleElements()
            
        }
        
    }
    
    fileprivate final var observations: [Observation] = []
    
    public final var totalAmount: Double { return elements.totalAmount }
    
    public final var totalAmountDidChange: ( (Double) -> Void )?
    
    public init() {
        
        self.elements = []
        
        self.prepare()
        
    }
    
    public init(arrayLiteral elements: Element...) {
        
        self.elements = elements
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        defer { isPrepared = true }
        
        handleElements()
        
    }
    
    fileprivate final func handleElements() {
        
        for element in elements {
            
            switch element {
                
            case let .item(controller):
                
                guard let item = controller.item else { return }
                
//                observations.append(
//                    item.isSelected.observe { [weak self] _ in
//                        
//                        guard let self = self else { return }
//                        
//                        self.totalAmountDidChange?(self.totalAmount)
//                        
//                    }
//                )
//                
//                observations.append(
//                    item.price.observe { [weak self] _ in
//                        
//                        guard let self = self else { return }
//                        
//                        self.totalAmountDidChange?(self.totalAmount)
//                        
//                    }
//                )
//                
//                observations.append(
//                    item.quantity.observe { [weak self] _ in
//                        
//                        guard let self = self else { return }
//                        
//                        self.totalAmountDidChange?(self.totalAmount)
//                        
//                    }
//                )
                
            }
            
        }
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index] }
    
}

fileprivate extension Array where Element == CheckoutCart.Element {
    
    fileprivate var totalAmount: Double {
        
        let items: [CartItem] = compactMap { element in
            
            guard case let .item(controller) = element else { return nil }
            
            return controller.item
            
        }
        
        return items.reduce(0.0) { result, item in
            
            if item.isSelected.value == false { return result }
            
            let quantity = item.quantity.value ?? 0
            
            let price = item.price.value ?? 0.0
            
            let amount = price * Double(quantity)
            
            return result + amount
            
        }
        
    }
    
}
