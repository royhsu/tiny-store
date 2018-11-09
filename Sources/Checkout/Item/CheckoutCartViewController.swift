//
//  CheckoutCartViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutCartViewController

public enum CheckoutCartElement {
    
    case item(
        CheckoutItem,
        style: CheckoutItemTemplate.Type,
        configure: (CheckoutItemTemplate) -> Void
    )
    
    public var template: Template {
        
        switch self {
            
        case let .item(
            item,
            style,
            configure
        ):
            
            let template = style.init(item: item)
            
            configure(template)
            
            return template
            
        }
        
    }
    
}

public final class CheckoutCartViewController: ViewController {
    
    private final let base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        return controller
        
    }()
    
    public final var elements: [CheckoutCartElement] = [] {
        
        didSet {
            
            var templates: [Template] = []
            
            for index in 0..<elements.count {
                
                let element = elements[index]
                
                let template = element.template
                    
//                let isLastSection = (index + 1 == elements.count)
                
                #warning("Unable to configure the template internally.")
//                template.isSeparatorHidden = isLastSection
                
                templates.append(template)
                
            }
            
            base.collectionView.sections = templates
            
            base.collectionView.layout?.invalidate()
            
        }
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
