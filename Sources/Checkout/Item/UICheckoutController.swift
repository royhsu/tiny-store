//
//  UICheckoutController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutController

#warning("development only.")
import MapKit

struct Recipient: ShippingRecipient {
    
    let name: Content<String>
    
    init(name: String) { self.name = Content(value: name) }
    
}

struct Address: ShippingAddress {
    
    let title: Content<String>
    
    let postalCode: Content<String>
    
    let country: Content<String>
    
    let state: Content<String>
    
    let city: Content<String>
    
    let line1: Content<String>
    
    let line2: Content<String>
    
    init(
        title: String,
        postalCode: String,
        country: String,
        state: String,
        city: String,
        line1: String,
        line2: String
    ) {
        
        self.title = Content(value: title)
        
        self.postalCode = Content(value: postalCode)
        
        self.country = Content(value: country)
        
        self.state = Content(value: state)
        
        self.city = Content(value: city)
        
        self.line1 = Content(value: line1)
        
        self.line2 = Content(value: line2)
        
    }
    
}

struct Destination: ShippingDestination {
    
    let recipient: ShippingRecipient
    
    let address: ShippingAddress
    
}

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
        
        let controller = UINavigationController(
            rootViewController: wrapViewController(cartViewController)
        )
        
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
        
        controller.title = NSLocalizedString(
            "Cart",
            comment: ""
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
            
            let viewController = ShippingController()
            
            viewController.serviceList.elements = [
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
            
            viewController.destination = Destination(
                recipient:
                Recipient(name: "Emily"),
                address: Address(
                    title: "Company",
                    postalCode: "10600",
                    country: "US",
                    state: "CA",
                    city: "Cupertino",
                    line1: "North Tantau Avenue",
                    line2: "4F"
                )
            )
            
            let serviceList = viewController.serviceList
            
            let dashboard = self.dashboardViewController.dashboard
            
            dashboard.shipping.value = serviceList.selectedService?.price.property.value ?? 0.0
            
            self.observations.append(
                serviceList.selectedItemIndex.property.observe { change in
                    
                    let price = serviceList.selectedService?.price.property.value ?? 0.0
                    
                    dashboard.shipping.value = price
                    
                }
            )
            
            viewController.title = NSLocalizedString(
                "Shipping & Delivery",
                comment: ""
            )
            
            self.backgroundNavigationController.pushViewController(
                self.wrapViewController(viewController),
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
    
    fileprivate final func wrapViewController(_ viewController: ViewController) -> ViewController {
        
        let containerViewController = ViewController()
        
        containerViewController.title = viewController.title
        
        let containerView = containerViewController.view!
        
        containerViewController.addChild(viewController)
        
        containerView.wrapSubview(
            viewController.view,
            within: \.layoutMarginsGuide
        )
        
        viewController.didMove(toParent: containerViewController)
        
        return containerViewController
        
    }
    
}
