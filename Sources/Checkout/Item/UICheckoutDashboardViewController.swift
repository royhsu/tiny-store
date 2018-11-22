//
//  UICheckoutDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardViewController

public final class UIDashboardViewController: UIViewController {
    
    private final lazy var collectionViewController: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = dashboard
        
        return controller
        
    }()
    
    public final let dashboard: Dashboard
    
    public init(_ dashboard: Dashboard? = nil) {
        
        self.dashboard = dashboard ?? Dashboard()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.dashboard = Dashboard()
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(collectionViewController)
        
        view.wrapSubview(collectionViewController.view)
        
        collectionViewController.didMove(toParent: self)
        
    }
    
}

public final class UICheckoutDashboardViewController: UIViewController {
    
    private final lazy var collectionViewController: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.alwaysBounceVertical = false
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = [ template ]
    
        return controller
        
    }()
    
    public final let dashboard: CheckoutDashboard
    
    public private(set) final lazy var template: UICheckoutDashboardView = { return UICheckoutDashboardView(dashboard: dashboard) }()
    
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
        
        addChild(collectionViewController)
        
        view.wrapSubview(collectionViewController.view)
        
        collectionViewController.didMove(toParent: self)
        
    }
    
}
