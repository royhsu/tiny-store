//
//  UIProductDetailComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/6/1.
//

// MARK: - UIProductDetailComponent

import UIKit
import TinyComponent

public final class UIProductDetailComponent: Component {
    
    // The base component.
    private final let listComponent: UIListComponent
    
    private final let headerComponent: UIProductDetailHeaderComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.headerComponent = UIProductDetailHeaderComponent()
    
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        listComponent.headerComponent = headerComponent
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() { listComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UIProductDetailComponent {
    
    public final var titleLabel: UILabel { return headerComponent.titleLabel }
    
    public final var subtitleLabel: UILabel { return headerComponent.subtitleLabel }
    
}
