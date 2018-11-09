//
//  CheckoutCart.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CheckoutCart

public struct CheckoutCart: ExpressibleByArrayLiteral, SectionCollection {
    
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
    
    private let elements: [Element]
    
    public init() { elements = [] }
    
    public init(arrayLiteral elements: Element...) { self.elements = elements }
    
    public var count: Int { return elements.count }
    
    public func section(at index: Int) -> Section { return elements[index].template }
    
}
