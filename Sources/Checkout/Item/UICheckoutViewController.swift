//
//  UICheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutViewController

import MapKit

public final class UICheckoutViewController: UIViewController {
    
    private final let checkoutView: UICheckoutView = {
        
        let view = UIView.loadView(
            UICheckoutView.self,
            from: Bundle(for: UICheckoutView.self)
        )!
        
        return view
        
    }()
    
    fileprivate final var observations: [Observation] = []
    
    private final lazy var cartViewController: CheckoutCartViewController = {
        
        let controller = CheckoutCartViewController(
            cart: [
                .item(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "Knee-length Wool Skirt",
                        color: "Dark Blue",
                        size: "S",
                        price: 19.0,
                        quantity: 1
                    ),
                    style: UICheckoutItemTemplate.self,
                    configure: { template in }
                ),
                .item(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "Long-sleeved Blouse",
                        color: "Light Blue",
                        size: "S",
                        price: 13.0,
                        quantity: 1
                    ),
                    style: UICheckoutItemTemplate.self,
                    configure: { template in }
                ),
                .item(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "High Heels",
                        color: "Purple Diamond",
                        size: "8",
                        price: 35.0,
                        quantity: 1
                    ),
                    style: UICheckoutItemTemplate.self,
                    configure: { template in }
                )
            ]
        )
        
        let cart = controller.cart
        
        observations.append(
            cart.totalAmount.observe { [weak self] change in
                
                self?.dashboardViewController.dashboard.subTotal.value = cart.totalAmount.value
                
            }
        )
        
        return controller
        
    }()
    
    public final lazy var dashboardViewController: UICheckoutDashboardViewController = {
        
        let controller = UICheckoutDashboardViewController()
        
        controller.dashboard.subTotal.value = cartViewController.cart.totalAmount.value
        
        return controller
        
    }()
    
    public final let visualEffectView = UIVisualEffectView(
        effect: UIBlurEffect(style: .regular)
    )
    
    public final override func loadView() { view = MKMapView() }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.wrapSubview(visualEffectView)
        
        visualEffectView.contentView.wrapSubview(checkoutView)
        
        addChild(cartViewController)
        
        checkoutView.backgroundContainerView.wrapSubview(
            cartViewController.view,
            within: \.layoutMarginsGuide
        )
        
        cartViewController.didMove(toParent: self)
        
        addChild(dashboardViewController)
        
        checkoutView.dashboardContainerView.wrapSubview(
            dashboardViewController.view,
            within: \.layoutMarginsGuide
        )
        
        dashboardViewController.didMove(toParent: self)
        
    }
    
}
