//
//  UICheckoutDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardViewController

public final class UICheckoutDashboardViewController: UIViewController {
    
    private final lazy var base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.alwaysBounceVertical = false
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = [ template ]
    
        return controller
        
    }()
    
    public final let dashboard: CheckoutDashboard
    
    public private(set) final lazy var template: UICheckoutDashboardTemplate = { return UICheckoutDashboardTemplate(dashboard: dashboard) }()
    
    public init(dashboard: CheckoutDashboard? = nil) {
        
        self.dashboard = dashboard ?? CheckoutDashboard()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.dashboard = CheckoutDashboard()
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() { }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
