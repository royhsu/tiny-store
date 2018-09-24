//
//  CheckoutSectionCollection.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/24.
//

// MARK: - CheckoutSectionCollection

import TinyKit

public enum CheckoutTemplate: Template {
    
    case shipping(ShippingTemplate)
    
    public var numberOfViews: Int {
        
        switch self {
            
        case let .shipping(template): return template.numberOfViews
            
        }
        
    }
    
    public func view(at index: Int) -> View {
        
        switch self {
            
        case let .shipping(template): return template.view(at: index)
            
        }
        
    }
    
}

public protocol CheckoutShipping {
    
    
    
}

public enum ShippingElement {
    
    case header
    
    case form(
        actionHandler: (CheckoutShippingAction) -> Void
    )
    
}

public enum CheckoutShippingAction: Action {
    
    public enum Input {
        
        case city(String)
        
        case postalCode(String)
        
        case address(String?)
        
    }
    
    case newInput(Input)
    
}

public protocol ShippingTemplate: Template {
    
    init(
        storage: CheckoutShipping,
        reducer: (CheckoutShipping) -> [ShippingElement]
    )
    
}

public struct AnyTemplate<Storage, Element>: Template {
    
    private let elements: [Element]
    
    private let generator: (Element) -> View
    
    public init(
        storage: CheckoutShipping,
        elements: [Element],
        generator: @escaping (Element) -> View
    ) {
        
        self.elements = elements
        
        self.generator = generator
        
    }
    
    public var numberOfViews: Int { return elements.count }
    
    public func view(at index: Int) -> View {
        
        let element = elements[index]
        
        return generator(element)
        
    }
    
}

public struct PatissierShippingTemplate: ShippingTemplate {

    private var elements: [ShippingElement]

    public init(
        storage: CheckoutShipping,
        reducer: (CheckoutShipping) -> [ShippingElement]
    ) { self.elements = reducer(storage) }

    public var numberOfViews: Int { return elements.count }

    public func view(at index: Int) -> View {

        let element = elements[index]

        switch element {

        case .header:

            let bundle = Bundle(for: CheckoutSectionHeaderView.self)

            let view = View.loadView(
                CheckoutSectionHeaderView.self,
                from: bundle
            )!

            #warning("TODO: should be defined in the locale system.")
            view.titleLabel.text = NSLocalizedString(
                "Shipping",
                comment: ""
            )

            return view

        case let .form(actionHandler):

            let bundle = Bundle(for: CheckoutShippingView.self)

            let view = View.loadView(
                CheckoutShippingView.self,
                from: bundle
            )!
            
            view.actionHandler = actionHandler

            #warning("TODO: should be defined in the locale system.")
//                view.titleLabel.text = NSLocalizedString(
//                    "Shipping",
//                    comment: ""
//                )

            return view

        }

    }

}
