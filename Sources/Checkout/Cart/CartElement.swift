//
//  CartElement.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CartElement

public enum CartElement: ViewCollection {

    case item(CartItemController & ViewRepresentable)

    private var representables: [ViewRepresentable] {
        
        switch self {
            
        case let .item(representable): return [ representable ]
            
        }
        
    }
    
    public var count: Int { return representables.count }

    public subscript(index: Int) -> ViewRepresentable { return representables[index] }

}
