//
//  CheckoutCartViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutCartViewController

public final class CheckoutCartViewController: ViewController {
    
    private final let base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        return controller
        
    }()
    
    public final var items: [CheckoutItem] = [] {
        
        didSet {
            
            var templates: [Template] = []
            
            for index in 0..<items.count {
                
                let item = items[index]
                
                var template = item.template.init(item: item)
                
                let isLastSection = (index + 1 == items.count)
                
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
