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
    
    #warning("injectable.")
    private final let backgroundViewController: CheckoutCartViewController<CheckoutDefaultItem> = {
        
        let controller = CheckoutCartViewController<CheckoutDefaultItem>()

        struct Item {

            let title: String

            let color: String

            let size: String

            let price: Double

        }

        let items = [
            Item(
                title: "Knee-length Wool Skirt",
                color: "Dark Blue",
                size: "S",
                price: 19.0
            ),
            Item(
                title: "Long-sleeved Blouse",
                color: "Light Blue",
                size: "S",
                price: 13.0
            ),
            Item(
                title: "High Heels",
                color: "Purple Diamond",
                size: "8",
                price: 35.0
            )
        ]

        controller.itemForms = items.map { item in

            return CheckoutDefaultItem(
                selectionField: .init(
                    property: Observable(true)
                ),
                titleField: .init(
                    property: Observable(item.title)
                ),
                descriptionField: .init(
                    property:  Observable("\(item.color) - \(item.size)")
                ),
                colorField: .init(
                    property: Observable(item.color)
                ),
                priceField: .init(
                    property: Observable(item.price)
                ),
                quantityField: .init(
                    property: Observable(1)
                )
            )

        }
        
        return controller
        
    }()
    
    #warning("injectable.")
    private final let dashboardViewController: UICheckoutDashboardViewController = {
        
        let controller = UICheckoutDashboardViewController()
        
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
        
        addChild(backgroundViewController)
        
        checkoutView.backgroundContainerView.wrapSubview(
            backgroundViewController.view,
            within: \.layoutMarginsGuide
        )
        
        backgroundViewController.didMove(toParent: self)
        
        addChild(dashboardViewController)
        
        checkoutView.dashboardContainerView.wrapSubview(
            dashboardViewController.view,
            within: \.layoutMarginsGuide
        )
        
        dashboardViewController.didMove(toParent: self)
        
    }
    
}
