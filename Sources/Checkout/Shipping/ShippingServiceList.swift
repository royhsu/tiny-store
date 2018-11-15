//
//  ShippingServiceList.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceList

public final class ShippingServiceList: ExpressibleByArrayLiteral, SectionCollection {
    
    public enum Element: ViewCollection {
        
        case item(ShippingServiceController & ViewController)
        
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
    
    public final func section(at index: Int) -> Section { return elements[index] }
    
}
