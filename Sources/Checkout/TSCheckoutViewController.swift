//
//  TSCheckoutViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - TSCheckoutViewController

#warning("development only.")
import MapKit

public final class TSCheckoutViewController: UIViewController {

    private final lazy var checkoutView: TSCheckoutNibView = {

        let view = UIView.loadView(
            TSCheckoutNibView.self,
            from: Bundle(for: TSCheckoutNibView.self)
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

//        let cart = controller.cart
//
//        cart.totalAmountDidChange = { [weak self] change in
//
//            guard let self = self else { return }

//            self.dashboardSubTotalViewController.row?.amount.property.value = cart.totalAmount
//
//            self.dashboardPayTotalViewController.row?.amount.property.value = self.payTotal

//        }

        controller.title = NSLocalizedString(
            "Cart",
            comment: ""
        )

        return controller

    }()
    
//    public private(set) final lazy var dashboardView: TSDashboardView = { return TSDashboardView() }()

//    public final lazy var dashboardViewController: UIDashboardViewController = {
//
//        let controller = UIDashboardViewController()
//
//        let buttonTitle = NSLocalizedString(
//            "Checkout",
//            comment: ""
//        )
//
//        controller.dashboard.elements = [
//            .subRow(dashboardSubTotalViewController),
//            .subRow(dashboardShippingViewController),
//            .subRow(dashboardPayTotalViewController),
//            .action(
//                UIDashboardActionButtonController(
//                    Action(
//                        title: buttonTitle + " →",
//                        handler: { [weak self] in self?.showShipping() }
//                    )
//                )
//            )
//        ]
//
//        return controller
//
//    }()

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

//        let serviceList = controller.serviceListViewController.list

//        dashboardShippingViewController.row?.amount.property.value = serviceList.selectedService?.price.property.value ?? 0.0
//
//        dashboardPayTotalViewController.row?.amount.property.value = payTotal

//        serviceList.selectedServiceDidChange = { [weak self] selectedService in
//
//            guard let self = self else { return }

//            let price = serviceList.selectedService?.price.property.value ?? 0.0
//
//            self.dashboardShippingViewController.row?.amount.property.value = price
//
//            self.dashboardPayTotalViewController.row?.amount.property.value = self.payTotal

//        }

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

//        checkoutView.dashboardContainerView.wrapSubview(
//            dashboardView,
//            within: \.layoutMarginsGuide
//        )
        
    }

    private final func wrapChild(_ viewController: ViewController) -> ViewController {

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

    private final func showShipping() {

        backgroundNavigationController.pushViewController(
            wrapChild(shippingViewController),
            animated: true
        )

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

}
