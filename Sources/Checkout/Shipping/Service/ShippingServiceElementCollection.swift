//
//  ShippingServiceElementCollection.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceElementCollection

public struct ElementCollection<Element>: ExpressibleByArrayLiteral {

    private var elements: [Element]

    public init<C: Collection>(_ collection: C)
    where
        C.Element == Element,
        C.Index == Int
    { self.elements = Array(collection) }

    public init(arrayLiteral elements: Element...) { self.init(elements) }

    public init() { self.init([]) }

}

extension ElementCollection: Collection {

    public var startIndex: Int { return elements.startIndex }

    public var endIndex: Int { return elements.endIndex }

    public func index(after i: Int) -> Int { return elements.index(after: i) }

    public subscript(index: Int) -> Element { return elements[index] }

}

extension ElementCollection: Emptible {

    public var isEmpty: Bool { return elements.isEmpty }

}

extension ElementCollection: NewSectionCollection where Element: NewViewCollection {

    public subscript(index: Int) -> NewSection { return elements[index] }

}

public enum ShippingServiceElement: NewViewCollection {
    
    case item(ShippingServiceController & ViewRepresentable)
    
    private var representables: [ViewRepresentable] {
        
        switch self {
            
        case let .item(representable):
            
            let makeSpacingView: (CGFloat) -> View = { spacing in
                
                let view = View()
                
                view.translatesAutoresizingMaskIntoConstraints = false
                
                view.heightAnchor.constraint(equalToConstant: spacing).isActive = true
                
                return view
                
            }
            
            let separatorView = View()
            
            separatorView.backgroundColor = .lightGray
            
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            
            separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            
            return [
                makeSpacingView(4.0),
                representable,
                makeSpacingView(4.0),
                separatorView
            ]
            
        }
        
    }
    
    public var count: Int { return representables.count }
    
    public subscript(index: Int) -> ViewRepresentable { return representables[index] }
    
}

public final class ShippingServiceElementCollection: NewSectionCollection, ExpressibleByArrayLiteral {
    
    public enum Element: NewViewCollection {
        
        case item(ShippingServiceController & ViewRepresentable)
        
        private var representables: [ViewRepresentable] {
            
            switch self {
                
            case let .item(representable):
                
                let makeSpacingView: (CGFloat) -> View = { spacing in
                    
                    let view = View()
                    
                    view.translatesAutoresizingMaskIntoConstraints = false
                    
                    view.heightAnchor.constraint(equalToConstant: spacing).isActive = true
                    
                    return view
                    
                }
                
                let separatorView = View()
                
                separatorView.backgroundColor = .lightGray
                
                separatorView.translatesAutoresizingMaskIntoConstraints = false
                
                separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
                
                return [
                    makeSpacingView(4.0),
                    representable,
                    makeSpacingView(4.0),
                    separatorView
                ]
                
            }
            
        }
        
        public var count: Int { return representables.count }
        
        public subscript(index: Int) -> ViewRepresentable { return representables[index] }

    }

    private final var isLoaded = false

    public final var elements: [Element] {

        willSet { observations = [] }

        didSet {

            guard isLoaded else { return }

            handleElements()

        }

    }

    private final var observations: [Observation] = []

    private final var selectedItemIndex: Int? {

        didSet {

            defer { selectedServiceDidChange?(selectedService) }

            guard let selectedItemIndex = selectedItemIndex else { return }

            // Make sure there is only one service selected every time.
            for index in 0..<self.elements.count {

                let isSelected = (index == selectedItemIndex)

                if !isSelected {

//                    switch elements[index] {
//
//                    case let .item(controller): controller.service?.isSelected.value = false
//
//                    }

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

    public init(_ elements: [Element] = []) {

        self.elements = elements

        self.load()

    }

    public convenience init(arrayLiteral elements: Element...) { self.init(elements) }

    private final func load() {

        defer { isLoaded = true }

//        handleElements()

    }

    private func handleElements() {

        let initialSelectedItemIndex = elements.isEmpty ? nil : 0

        observations = elements.enumerated().compactMap { index, element in

            switch element {

            case let .item(controller):

//                let isInitialSelectedItem = (index == initialSelectedItemIndex)
//
//                if isInitialSelectedItem { controller.service?.isSelected.value = true }
                
                return nil

//                return controller.service?.isSelected.property.observe { [weak self] change in
//
//                    guard let self = self else { return }
//
//                    let isSelected = (change.currentValue == true)
//
//                    let isSameItemSelectionToggled = (self.selectedItemIndex == index)
//
//                    if isSameItemSelectionToggled {
//
//                        self.selectedItemIndex = isSelected ? index : nil
//
//                    }
//                    else {
//
//                        if isSelected { self.selectedItemIndex = index }
//
//                    }
//
//                }

            }

        }

        selectedItemIndex = initialSelectedItemIndex

    }

    public final var count: Int { return elements.count }

    public final subscript(index: Int) -> Element { return elements[index] }
    
    public final subscript(index: Int) -> NewSection { return elements[index] }

}
