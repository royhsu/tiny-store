//
//  CheckoutShippingViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/14.
//

// MARK: - CheckoutShippingViewController

public final class CheckoutShippingViewController: ViewController {
    
    private final lazy var base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = shipping
        
        return controller
        
    }()
    
    public final let shipping: CheckoutShipping
    
    public init(_ shipping: CheckoutShipping? = nil) {
        
        self.shipping = shipping ?? CheckoutShipping()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.shipping = CheckoutShipping()
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
