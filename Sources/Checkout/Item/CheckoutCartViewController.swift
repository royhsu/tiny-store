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
    
    public final var cart = CheckoutCart() {
        
        didSet {
            
            base.collectionView.sections = cart
            
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
