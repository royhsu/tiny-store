//
//  ShippingServiceElement.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceElement

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
