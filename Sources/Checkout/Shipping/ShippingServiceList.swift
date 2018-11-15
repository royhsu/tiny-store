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
    
    fileprivate final var observations: [Observation] = []
    
    public final let selectedItemIndex = Observable<Int>()
    
    public init() {
        
        self.elements = []
        
        self.prepare()
        
    }
    
    public init(arrayLiteral elements: Element...) {
        
        self.elements = elements
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        let initialSelectedItemIndex = elements.isEmpty ? nil : 0
        
        observations = elements.enumerated().compactMap { index, element in
            
            switch element {
            
            case let .item(controller):
                
                let isInitialSelectedItem = (index == initialSelectedItemIndex)
                
                if isInitialSelectedItem { controller.service?.isSelected.property.value = true }
                
                return controller.service?.isSelected.property.observe { [weak self] change in
                    
                    let isSelected = (change.currentValue == true)
                    
                    if isSelected { self?.selectedItemIndex.value = index }
                    
                }
                
            }
            
        }
        
        selectedItemIndex.value = initialSelectedItemIndex
        
        // Make sure there is only one service selected every time.
        observations.append(
            selectedItemIndex.observe { [weak self] change in
                
                guard
                    let self = self,
                    let selectedIndex = change.currentValue
                else { return }
                
                for index in 0..<self.elements.count {
                    
                    let isSelected = (index == selectedIndex)
                    
                    if !isSelected {
                        
                        switch self.elements[index] {
                            
                        case let .item(controller): controller.service?.isSelected.property.value = false
                                
                        }
                        
                    }
                    
                }
                
            }
        )
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index] }
    
}
