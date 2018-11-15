//
//  ShippingServiceListViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceListViewController

public final class ShippingServiceListViewController: ViewController {
    
    private final lazy var base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = list
        
        return controller
        
    }()
    
    public final let list: ShippingServiceList
    
    public init(_ list: ShippingServiceList? = nil) {
        
        self.list = list ?? ShippingServiceList()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.list = ShippingServiceList()
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
