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
    
    fileprivate final var isPrepared = false
    
    public final var elements: [Element] {
        
        willSet { observations = [] }
        
        didSet {
            
            guard isPrepared else { return }
            
            handleElements()
            
        }
        
    }
    
    fileprivate final var observations: [Observation] = []
    
    private final var selectedItemIndex: Int? {
        
        didSet {
            
            defer { selectedServiceDidChange?(selectedService) }
            
            guard let selectedItemIndex = selectedItemIndex else { return }
            
            // Make sure there is only one service selected every time.
            for index in 0..<self.elements.count {
                
                let isSelected = (index == selectedItemIndex)
                
                if !isSelected {
                    
                    switch elements[index] {
                        
                    case let .item(controller): controller.service?.isSelected.property.value = false
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    public final var selectedService: ShippingService? {
        
        guard let selectedItemIndex = selectedItemIndex else { return nil }
        
        let element = elements[selectedItemIndex]
        
        switch element {
            
        case let .item(controller): return controller.service
            
        }
        
    }
    
    public final var selectedServiceDidChange: ( (ShippingService?) -> Void )?
    
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
    
    fileprivate func handleElements() {
        
        let initialSelectedItemIndex = elements.isEmpty ? nil : 0
        
        observations = elements.enumerated().compactMap { index, element in
            
            switch element {
                
            case let .item(controller):
                
                let isInitialSelectedItem = (index == initialSelectedItemIndex)
                
                if isInitialSelectedItem { controller.service?.isSelected.property.value = true }
                
                return controller.service?.isSelected.property.observe { [weak self] change in
                    
                    guard let self = self else { return }
                    
                    let isSelected = (change.currentValue == true)
                    
                    let isSameItemSelectionToggled = (self.selectedItemIndex == index)
                    
                    if isSameItemSelectionToggled {
                        
                        self.selectedItemIndex = isSelected ? index : nil
                        
                    }
                    else {
                        
                        if isSelected { self.selectedItemIndex = index }
                        
                    }
                    
                }
                
            }
            
        }
        
        selectedItemIndex = initialSelectedItemIndex
        
    }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index] }
    
}
