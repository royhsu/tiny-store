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
    
    private final var selectedIndex: Int? {
        
        didSet {
            
            DispatchQueue.main.async { [weak self] in
                
                guard
                    let self = self
                else { return }
                
                self.observations = []
                
                self.updateSelectedService()
                
                for index in 0..<self.elements.count {

                    let element = self.elements[index]

                    guard
                        let template = element.template as? CheckoutShippingServiceTemplate
                    else { continue }
 
                    self.observations.append(
                        template.service.isSelected.property.observe { change in

                            let isSelected = (change.currentValue == true)
                            
                            if isSelected { self.selectedIndex = index }

                        }
                    )

                }
                
            }
            
        }
        
    }
    
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
        
        var initialIndex: Int?
        
        for index in 0..<elements.count {
            
            let element = elements[index]
            
            if let template = element.template as? CheckoutShippingServiceTemplate {
            
                let isSelected = (template.service.isSelected.property.value == true)
                
                if isSelected { initialIndex = index }
                
            }
            
        }
        
        selectedIndex = initialIndex
        
    }
    
    fileprivate final func updateSelectedService() {
        
        guard
            let selectedIndex = selectedIndex
        else { return }
        
        for index in 0..<elements.count {
            
            let element = elements[index]
            
            let isSelected = (index == selectedIndex)
            
            let template = element.template as? CheckoutShippingServiceTemplate
            
            template?.service.isSelected.property.value = isSelected
            
        }
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index].template }
    
}
