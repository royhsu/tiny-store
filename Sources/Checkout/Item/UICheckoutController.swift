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

private struct Action: DashboardAction {
    
    internal let title: Content<String>
    
    internal var handler: ( () -> Void )?
    
    internal init(
        title: String? = nil,
        handler: ( () -> Void )? = nil
    ) {
        
        self.title = Content(value: title)
        
        self.handler = handler
        
    }
    
}

private struct SubRow: DashboardRow {
    
    internal let title: Content<String>
    
    internal let amount: Content<Double>
    
    internal init(
        title: String,
        amount: Double
        ) {
        
        self.title = Content(value: title)
        
        self.amount = Content(value: amount)
        
    }
    
}

public final class UICheckoutController: UIViewController {
    
    private final lazy var checkoutView: UICheckoutView = {
        
        let view = UIView.loadView(
            UICheckoutView.self,
            from: Bundle(for: UICheckoutView.self)
        )!
        
        return view
        
    }()
    
    fileprivate final var observations: [Observation] = []
    
    private final lazy var backgroundNavigationController: UINavigationController = {
        
        let controller = UINavigationController(
            rootViewController: wrapChild(cartViewController)
        )
        
        return controller
        
    }()
    
    private final lazy var cartViewController: CheckoutCartViewController = {
        
        let controller = CheckoutCartViewController()
        
        controller.cart.elements = [
            .item(
                UICheckoutCartItemViewController(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "Knee-length Wool Skirt",
                        color: "Dark Blue",
                        size: "S",
                        price: 19.0,
                        quantity: 1
                    )
                )
            ),
            .item(
                UICheckoutCartItemViewController(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "Long-sleeved Blouse",
                        color: "Light Blue",
                        size: "S",
                        price: 13.0,
                        quantity: 1
                    )
                )
            ),
            .item(
                UICheckoutCartItemViewController(
                    CheckoutApparelItem(
                        isSelected: true,
                        title: "High Heels",
                        color: "Purple Diamond",
                        size: "8",
                        price: 35.0,
                        quantity: 1
                    )
                )
            )
        ]
        
        let cart = viewController.cart
        
        cart.totalAmountDidChange = { [weak self] change in

            guard let self = self else { return }
            
            self.dashboardSubTotalViewController.row?.amount.property.value = cart.totalAmount
            
            self.dashboardPayTotalViewController.row?.amount.property.value = self.payTotal

        }
        
        controller.title = NSLocalizedString(
            "Cart",
            comment: ""
        )
        
        return controller
        
    }()
    
    private final lazy var dashboardSubTotalViewController: DashboardRowController & ViewController = {
        
        let controller = UIDashboardSubRowViewController(
            SubRow(
                title: "SubTotal",
                amount: cartViewController.cart.totalAmount
            )
        )
        
        return controller
        
    }()
    
    private final lazy var dashboardShippingViewController: DashboardRowController & ViewController = {
        
        let controller = UIDashboardSubRowViewController(
            SubRow(
                title: "Shipping",
                amount: 0.0
            )
        )
        
        return controller
        
    }()
    
    private final var payTotal: Double {
        
        let subTotal = dashboardSubTotalViewController.row?.amount.property.value ?? 0.0
        
        let shipping = dashboardShippingViewController.row?.amount.property.value ?? 0.0
        
        return subTotal + shipping
        
    }
    
    private final lazy var dashboardPayTotalViewController: DashboardRowController & ViewController = {
        
        let controller = UIDashboardSubRowViewController(
            SubRow(
                title: "Pay Total",
                amount: 0.0
            )
        )
        
        controller.row?.amount.property.value = payTotal
        
        return controller
        
    }()
    
    public final lazy var dashboardViewController: UIDashboardViewController = {
        
        let controller = UIDashboardViewController()
        
        let buttonTitle = NSLocalizedString(
            "Checkout",
            comment: ""
        )
        
        controller.dashboard.elements = [
            .subRow(dashboardSubTotalViewController),
            .subRow(dashboardShippingViewController),
            .subRow(dashboardPayTotalViewController),
            .action(
                UIDashboardActionButtonController(
                    Action(
                        title: buttonTitle + " →",
                        handler: { [weak self] in self?.showShipping() }
                    )
                )
            )
        ]
        
        return controller
        
    }()
    
    private final lazy var shippingViewController: ShippingViewController = {
        
        let controller = ShippingViewController()
        
        controller.serviceList.elements = [
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
        
        controller.destination = Destination(
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
        
        let serviceList = controller.serviceList
        
        dashboardShippingViewController.row?.amount.property.value = serviceList.selectedService?.price.property.value ?? 0.0
        
        dashboardPayTotalViewController.row?.amount.property.value = payTotal
        
        serviceList.selectedServiceDidChange = { [weak self] selectedService in
            
            guard let self = self else { return }
            
            let price = serviceList.selectedService?.price.property.value ?? 0.0
            
            self.dashboardShippingViewController.row?.amount.property.value = price
            
            self.dashboardPayTotalViewController.row?.amount.property.value = self.payTotal
            
        }
        
        controller.title = NSLocalizedString(
            "Shipping & Delivery",
            comment: ""
        )
        
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
        
        let wrappedDashboardViewController = wrapChild(dashboardViewController)
        
        addChild(wrappedDashboardViewController)
        
        checkoutView.dashboardContainerView.wrapSubview(wrappedDashboardViewController.view)
        
        wrappedDashboardViewController.didMove(toParent: self)
    
    }
    
    fileprivate final func wrapChild(_ viewController: ViewController) -> ViewController {
        
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
    
    fileprivate final func showShipping() {

        backgroundNavigationController.pushViewController(
            wrapChild(shippingViewController),
            animated: true
        )
        
    }
    
}
