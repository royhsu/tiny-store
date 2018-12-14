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
            
        case let .item(representable):
            
            return [
                makeSpacingView(spacing: 12.0),
                representable,
                makeSpacingView(spacing: 12.0),
                makeSeparatorView()
            ]
            
        }
        
    }
    
    public var count: Int { return representables.count }

    public subscript(index: Int) -> ViewRepresentable { return representables[index] }

}

fileprivate extension CartElement {
    
    fileprivate func makeSpacingView(spacing: CGFloat) -> View {
        
        let view = View()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: spacing).isActive = true
        
        return view
        
    }
    
    fileprivate func makeSeparatorView() -> View {
        
        let view = View()
        
        view.backgroundColor = .lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return view
        
    }
    
}
