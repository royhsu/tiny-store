//
//  CheckoutCartViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutCartViewController

public final class CheckoutCartViewController<Item>: ViewController where Item: CheckoutItem {
    
    private final let base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        return controller
        
    }()
    
    public final var itemForms: [Item] = [] {
        
        didSet {
            
            var templates: [Template] = []
            
            for index in 0..<itemForms.count {
                
                let itemForm = itemForms[index]
                
                #warning("inject the cross-platform template.")
                var template = UICheckoutItemTemplate(
                    selection: itemForm.selection,
                    title: itemForm.title,
                    description: itemForm.description,
                    price: itemForm.price,
                    quantity: itemForm.quantity
                )
                
                let isLastSection = (index + 1 == itemForms.count)
                
                template.isSeparatorHidden = isLastSection
                
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
