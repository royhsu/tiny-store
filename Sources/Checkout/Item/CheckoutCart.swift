//
//  CheckoutCart.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CheckoutCart

public final class CheckoutCart: ExpressibleByArrayLiteral, SectionCollection {
    
    public enum Element {
        
        case item(
            CheckoutItem,
            style: CheckoutItemTemplate.Type,
            configure: (CheckoutItemTemplate) -> Void
        )
        
        public var template: Template {
            
            switch self {
                
            case let .item(
                item,
                style,
                configure
            ):
                
                let template = style.init(item: item)
                
                configure(template)
                
                return template
                
            }
            
        }
        
    }
    
    private final let elements: [Element]
    
    fileprivate final var observations: [Observation] = []
    
    public final let totalAmount: Observable<Double>
    
    public init() {
        
        self.elements = []

        self.totalAmount = Observable(0.0)
        
        self.prepare()
        
    }
    
    public init(arrayLiteral elements: Element...) {
        
        self.elements = elements
        
        let totalAmount = CheckoutCart.calculateTotalAmount(for: elements)
        
        self.totalAmount = Observable(totalAmount)
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        for element in elements {
            
            switch element {
                
            case let .item(item, _, _):
                
                observations.append(
                    item.isSelected.property.observe { [weak self] _ in
                        
                        guard
                            let self = self
                        else { return }
                        
                        self.totalAmount.value = CheckoutCart.calculateTotalAmount(for: self.elements)
                        
                    }
                )
                
                observations.append(
                    item.price.property.observe { [weak self] _ in
                        
                        guard
                            let self = self
                        else { return }
                        
                        self.totalAmount.value = CheckoutCart.calculateTotalAmount(for: self.elements)
                        
                    }
                )
                
                observations.append(
                    item.quantity.property.observe { [weak self] _ in
                        
                        guard
                            let self = self
                        else { return }
                        
                        self.totalAmount.value = CheckoutCart.calculateTotalAmount(for: self.elements)
                        
                    }
                )
                
            }
            
        }
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index].template }
    
    fileprivate static func calculateTotalAmount(
        for elements: [Element]
    )
    -> Double {
        
        let items: [CheckoutItem] = elements.compactMap { element in
                
            guard
                case let .item(item, _, _) = element
            else { return nil }
            
            return item
            
        }
        
        return items.reduce(0.0) { result, item in
            
            if item.isSelected.property.value == false { return result }

            let quantity = item.quantity.property.value ?? 0
            
            let price = item.price.property.value ?? 0.0
            
            let amount = price * Double(quantity)
            
            return result + amount

        }

    }
    
}
