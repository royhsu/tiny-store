//
//  UIProductDetailHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/6/1.
//

// MARK: - UIProductDetailHeaderComponent

import UIKit
import TinyComponent

internal final class UIProductDetailHeaderComponent: Component {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductDetailHeaderView>
    
    private final var headerView: UIProductDetailHeaderView { return itemComponent.itemView }
    
    internal init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            itemView: UIView.load(
                UIProductDetailHeaderView.self,
                fromNibIn: bundle
            )!
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() { }
    
    // MARK: Component
    
    internal final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    internal final func render() { itemComponent.render() }
    
    // MARK: ViewRenderable
    
    internal final var view: View { return itemComponent.view }
    
    internal final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

extension UIProductDetailHeaderComponent {
    
    internal final var titleLabel: UILabel { return headerView.titleLabel }
    
    internal final var subtitleLabel: UILabel { return headerView.subtitleLabel }
    
}
