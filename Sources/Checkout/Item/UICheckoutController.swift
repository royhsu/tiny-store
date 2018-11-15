//
//  UICheckoutController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutController

#warning("development only.")
import MapKit

public final class UICheckoutController: UIViewController {
    
    private final let checkoutView: UICheckoutView = {
        
        let view = UIView.loadView(
            UICheckoutView.self,
            from: Bundle(for: UICheckoutView.self)
        )!
        
        return view
        
    }()
    
    fileprivate final var observations: [Observation] = []
    
    private final lazy var backgroundNavigationController: UINavigationController = {
        
        let controller = UINavigationController(rootViewController: cartViewController)
        
        return controller
        
    }()
    
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
        
        let buttonTitle = NSLocalizedString(
            "Checkout",
            comment: ""
        )
        
        controller.template.setAction(title: buttonTitle + " →") { [weak self] in
            
            guard let self = self else { return }
            
            struct Service: ShippingService {
                
                let isSelected: Content<Bool>
                
                let title: Content<String>
                
                let price: Content<Double>
                
                init(
                    isSelected: Bool = false,
                    title: String,
                    price: Double
                ) {
                    
                    self.isSelected = Content(value: isSelected)
                    
                    self.title = Content(value: title)
                    
                    self.price = Content(value: price)
                    
                }
                
            }

            let viewController = ShippingServiceListViewController(
                [
                    .item(
                        UIShippingServiceViewController(
                            Service(
                                isSelected: false,
                                title: "UPS",
                                price: 3.0
                            )
                        )
                    ),
                    .item(
                        UIShippingServiceViewController(
                            Service(
                                isSelected: false,
                                title: "DHL Express",
                                price: 5.0
                            )
                        )
                    )
                ]
            )
            
            let list = viewController.list
            
            let dashboard = self.dashboardViewController.dashboard
            
            dashboard.shipping.value = list.selectedService?.price.property.value ?? 0.0
            
            self.observations.append(
                list.selectedItemIndex.observe { change in
                    
                    let price = list.selectedService?.price.property.value ?? 0.0
                    
                    dashboard.shipping.value = price
                    
                }
            )
            
            self.backgroundNavigationController.pushViewController(
                viewController,
                animated: true
            )
            
        }
        
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
        
        addChild(backgroundNavigationController)
        
        checkoutView.backgroundContainerView.wrapSubview(backgroundNavigationController.view)
        
        backgroundNavigationController.didMove(toParent: self)
        
        addChild(dashboardViewController)
        
        checkoutView.dashboardContainerView.wrapSubview(
            dashboardViewController.view,
            within: \.layoutMarginsGuide
        )
        
        dashboardViewController.didMove(toParent: self)
        
    }
    
}
