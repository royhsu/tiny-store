//
//  CheckoutShipping.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - CheckoutShipping

public final class CheckoutShipping: ExpressibleByArrayLiteral, SectionCollection {
    
    public enum Element: TemplateRepresentable {
        
        case service(CheckoutShippingServiceTemplate)
        
        public var template: Template {
            
            switch self {
                
            case let .service(template): return template
                
            }
            
        }
        
    }
    
    private final let elements: [Element]
    
    public init() {
        
        self.elements = []
        
        self.prepare()
        
    }
    
    public init(arrayLiteral elements: Element...) {
        
        self.elements = elements
        
        self.prepare()
        
    }
 
    fileprivate final func prepare() { }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index].template }
    
}
