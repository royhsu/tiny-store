//
//  TSCheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - TSCheckoutViewController

#warning("development only.")
import MapKit

public final class TSCheckoutViewController: UIViewController, UINavigationControllerDelegate {
    
    private enum Step {
        
        case cart, shipping
        
        var actionTitle: String {
            
            switch self {
                
            case .cart:
                
                let title = NSLocalizedString(
                    "Checkout",
                    comment: ""
                )
                
                return title + " →"
                
            case .shipping:
                
                let title = NSLocalizedString(
                    "Next",
                    comment: ""
                )
                
                return title + " →"
                
            }
            
        }
        
    }
    
    private final class StepViewController: ViewController {
        
        internal final let step: Step
        
        internal final let wrappedViewController: ViewController
        
        internal init(
            step: Step,
            wrappedViewController: ViewController
        ) {
            
            self.step = step
            
            self.wrappedViewController = wrappedViewController
            
            super.init(
                nibName: nil,
                bundle: nil
            )
            
        }
        
        internal required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
        internal final override func viewDidLoad() {
            
            super.viewDidLoad()
            
            title = wrappedViewController.title
            
            addChild(wrappedViewController)
            
//            if #available(iOS 11.0, *) {
//
//                view.wrapSubview(
//                    wrappedViewController.view,
//                    within: \.safeAreaLayoutGuide
//                )
//
//            }
//            else {
            
                view.wrapSubview(
                    wrappedViewController.view,
                    within: \.layoutMarginsGuide
                )
                
//            }
            
            wrappedViewController.didMove(toParent: self)
            
        }
        
    }
    
    private final var currentStep: Step = .cart {
        
        didSet {
            
            checkoutView.dashboardView.actionButton.isEnabled = false
            
            checkoutView.dashboardView.actionButton.setTitle(
                nil,
                for: .normal
            )
            
            switch currentStep {
                
            case .cart: break
                
            case .shipping:
                
                cartViewController.view.isHidden = true
                
                backgroundNavigationController.pushViewController(
                    StepViewController(
                        step: .shipping,
                        wrappedViewController: shippingViewController
                    ),
                    animated: true
                )
                
            }
            
            checkoutView.dashboardView.actionButton.setTitle(
                currentStep.actionTitle,
                for: .normal
            )
            
            checkoutView.dashboardView.actionButton.isEnabled = true
            
        }
        
    }

    private final lazy var checkoutView: TSCheckoutNibView = {

        let view = UIView.loadView(
            TSCheckoutNibView.self,
            from: Bundle(for: TSCheckoutNibView.self)
        )!
        
        view.dashboardView.actionButton.setTitle(
            currentStep.actionTitle,
            for: .normal
        )
        
        view.dashboardView.actionButton.addTarget(
            self,
            action: #selector(performAction),
            for: .touchUpInside
        )

        return view

    }()

    private final var selectedServiceObservation: Observation?

    private final lazy var backgroundNavigationController: UINavigationController = {

        let controller = UINavigationController(
            rootViewController: StepViewController(
                step: .cart,
                wrappedViewController: cartViewController
            )
        )

        controller.delegate = self
        
        return controller

    }()

    private final lazy var cartViewController: CartViewController = {

        let controller = CartViewController()

        controller.elements = [
            .item(
                TSCartItemViewController(
                    item: Apparel(
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
                TSCartItemViewController(
                    item: Apparel(
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
                TSCartItemViewController(
                    item: Apparel(
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
        
        controller.totalAmountDidChange = { [weak self] controller in
        
            guard let self = self else { return }

            self.checkoutView.dashboardView.subTotal = controller.totalAmount

        }

        controller.title = NSLocalizedString(
            "Cart",
            comment: ""
        )

        return controller

    }()

    private final lazy var shippingViewController: TSShippingViewController = {

        let controller = TSShippingViewController()

        controller.serviceListViewController.elements = [
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: false,
                        title: "UPS",
                        price: 3.0
                    )
                )
            ),
            .item(
                TSShippingServiceViewController(
                    service: DefaultShippingService(
                        isSelected: false,
                        title: "DHL Express",
                        price: 5.0
                    )
                )
            )
        ]

        selectedServiceObservation = controller.serviceListViewController.selectedIndex.observe { [weak self] _ in
            
            guard let self = self else { return }
            
            self.checkoutView.dashboardView.shipping = controller.serviceListViewController.selectedService?.price.value ?? 0.0
            
        }

        controller.destinationCardViewController.editDestinationHandler = { [weak self] _ in self?.showDestionationEditor() }

        controller.title = NSLocalizedString(
            "Shipping & Delivery",
            comment: ""
        )

        return controller

    }()

    private final lazy var destinationEditorViewController: TSShippingDestinationEditorController = {

        let controller = TSShippingDestinationEditorController()

        controller.addressStateHandler = { _ in print("State picker...") }

        controller.addressCityHandler = { _ in print("City picker...") }

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
        
        checkoutView.dashboardView.subTotal = cartViewController.totalAmount
        
        checkoutView.dashboardView.shipping = shippingViewController.serviceListViewController.selectedService?.price.value ?? 0.0
        
    }
    
    private final func showDestionationEditor() {

        checkoutView.isHidden = true

        destinationEditorViewController.recipient = shippingViewController.destinationCardViewController.recipient

        destinationEditorViewController.address = shippingViewController.destinationCardViewController.address

        let keyboardViewController = UIKeyboardController()

        keyboardViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(endEditingDestination)
        )

        keyboardViewController.setContentViewController(
            destinationEditorViewController,
            animated: true
        )

        let navigationController = UINavigationController(rootViewController: keyboardViewController)

        navigationController.modalPresentationStyle = .overCurrentContext

        present(
            navigationController,
            animated: true,
            completion: nil
        )

    }

    @objc
    public final func endEditingDestination(_ sender: Any) {

        checkoutView.isHidden = false

        shippingViewController.destinationCardViewController.recipient = destinationEditorViewController.recipient

        shippingViewController.destinationCardViewController.address = destinationEditorViewController.address

        presentedViewController?.dismiss(
            animated: true,
            completion: nil
        )

    }
    
    @objc
    public final func performAction(_ button: TSButton) {
        
        switch currentStep {
            
        case .cart: currentStep = .shipping
            
        case .shipping: break
            
        }
        
    }
    
    // MARK: - UINavigationControllerDelegate
    
    public final func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        
        guard let stepViewController = viewController as? StepViewController else { return }
        
        switch stepViewController.step {
            
        case .cart: cartViewController.view.isHidden = false
            
        case .shipping: shippingViewController.view.isHidden = false
            
        }
        
    }
    
    public final func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        
        guard let stepViewController = viewController as? StepViewController else { return }
        
        if currentStep != stepViewController.step { currentStep = stepViewController.step }
        
    }
    
}
