//
//  CheckoutShipping.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - CheckoutShipping

@available(*, deprecated: 1.0)
public final class CheckoutShipping: ExpressibleByArrayLiteral, SectionCollection {
    
    public enum Element: TemplateRepresentable {
        
        case service(CheckoutShippingServiceTemplate)
        
        public var template: Template {
            
            switch self {
                
            case let .service(template): return template
                
            }
            
        }
        
    }
    
    public final let selectedIndex = Content(value: 0)
    
    fileprivate final var observations: [Observation] = []
    
    private final let elements: [Element]
    
    public init() {
        
        self.elements = []
        
        self.prepare()
        
    }
    
    public init(arrayLiteral elements: Element...) {
        
        self.elements = elements
        
        self.prepare()
        
    }
 
    fileprivate final func prepare() {
        
        for index in 0..<elements.count {
            
            let element = elements[index]
            
            if let template = element.template as? CheckoutShippingServiceTemplate {
                
                let isSelected = (index == selectedIndex.property.value)
                
                template.service.isSelected.property.value = isSelected
                
                observations.append(
                    template.service.isSelected.property.observe { [weak self] change in
                        
                        let isSelected = (change.currentValue == true)

                        if isSelected { self?.selectedIndex.property.value = index }
                        
                    }
                )
            
            }
            
        }
        
        // Make sure there is only one service selected every time.
        observations.append(
            selectedIndex.property.observe { [weak self] change in
                
                guard
                    let self = self,
                    let selectedIndex = change.currentValue
                else { return }
                
                for index in 0..<self.elements.count {
                    
                    if index == selectedIndex { continue }
                    
                    let element = self.elements[index]
                    
                    let template = element.template as? CheckoutShippingServiceTemplate
                    
                    template?.service.isSelected.property.value = false
                    
                }
                
            }
        )
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index].template }
    
}
