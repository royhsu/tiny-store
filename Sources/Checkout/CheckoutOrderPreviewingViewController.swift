//
//  CheckoutOrderPreviewingViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/29.
//

// MARK: - CheckoutOrderPreviewingViewController

open class CheckoutOrderPreviewingViewController: ViewController, CheckoutOrderPreviewingStep {
    
    private final let base = CollectionViewController()
    
    public var _sections: SectionCollection {
        
        get { return base.collectionView.sections }
        
        set { base.collectionView.sections = newValue }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
    fileprivate var _makeOrder: Optional< (Result<Void>) -> Void >
    
    public final func makeOrder(
        _ completion: @escaping (Result<Void>) -> Void
    ) { _makeOrder = completion }
    
}
