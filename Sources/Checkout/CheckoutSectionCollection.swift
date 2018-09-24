//
//  CheckoutSectionCollection.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutSectionCollection

import TinyKit

public struct CheckoutSectionCollection: SectionCollection {
    
    public enum Section: Template {
        
        public typealias Element = Any
        
        #warning("Should replace with a protocol template for shipping.")
        case shipping(AnyTemplate<ShippingElement, Void>)
        
        public var storage: Any {
            
            switch self {
                
            case let .shipping(template): return template.storage
                
            }
            
        }
        
        public var numberOfElements: Int {
            
            switch self {
                
            case let .shipping(template): return template.numberOfElements
                
            }
            
        }
        
        public func view(at index: Int) -> View {
            
            switch self {
                
            case let .shipping(template): return template.view(at: index)
                
            }
            
        }
        
    }
    
    private let sections: [Section]
    
    public init(
        sections: [Section] = []
    ) {
        
        self.sections = sections
        
    }
    
    public var count: Int { return sections.count }
    
    public func section(at index: Int) -> Section { return sections[index] }
    
}

public enum ShippingElement {
    
    case header
    
}

public enum Patissier {
    
    public struct ShippingTemplate: Template {
    
        public typealias Element = ShippingElement
        
        private let elements: [Element]
        
        public let storage: Void = ()
        
        public init(
            elements: [Element]
        ) { self.elements = elements }
        
        public var numberOfElements: Int { return elements.count }
        
        public func view(at index: Int) -> View {
            
            let element = elements[index]
            
            switch element {
                
            case .header:
                
                let bundle = Bundle(for: CheckoutSectionHeaderView.self)
                
                let headerView = View.loadView(
                    CheckoutSectionHeaderView.self,
                    from: bundle
                )!
                
                #warning("TODO: should be defined in the locale system.")
                headerView.titleLabel.text = NSLocalizedString(
                    "Shipping",
                    comment: ""
                )
                
                return headerView
                
            }
            
        }
    
    }

}
