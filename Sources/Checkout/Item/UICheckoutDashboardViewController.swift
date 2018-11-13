//
//  UICheckoutDashboardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardViewController

public struct CheckoutDashboard {
    
    public let subTotal: Observable<Double>
    
    public let shipping: Observable<Double>
    
    public var payTotal: Double {
        
        let subTotal = self.subTotal.value ?? 0.0
        
        let shipping = self.shipping.value ?? 0.0
        
        return subTotal + shipping
        
    }
    
    public init(
        subTotal: Double = 0.0,
        shipping: Double = 0.0
    ) {
        
        self.subTotal = Observable(subTotal)
        
        self.shipping = Observable(shipping)
        
    }
    
}
public final class UICheckoutDashboardViewController: UIViewController {
    
    private final lazy var base: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.alwaysBounceVertical = false
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = [
            UICheckoutDashboardTemplate(dashboard: dashboard)
        ]
    
        return controller
        
    }()
    
    public final let dashboard: CheckoutDashboard
    
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
