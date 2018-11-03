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
    
    private final let backgroundViewController: CheckoutCartViewController<CheckoutDefaultItemForm> = {
        
        let controller = CheckoutCartViewController<CheckoutDefaultItemForm>()

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

            let selection = Observable<Bool>()

            selection.value = true

            let title = Observable<String>()

            title.value = item.title

            let description = Observable<String>()

            description.value = "\(item.color) - \(item.size)"

            let color = Observable<String>()

            color.value = item.color

            let price = Observable<Double>()

            price.value = item.price

            let quantity = Observable<Int>()

            quantity.value = 1

            return CheckoutDefaultItemForm(
                selectionField: .init(selection: selection),
                titleField: .init(title: title),
                descriptionField: .init(description: description),
                colorField: .init(color: color),
                priceField: .init(price: price),
                quantityField: .init(quantity: quantity)
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
        
        checkoutView.backgroundContainerView.wrapSubview(backgroundViewController.view)
        
        backgroundViewController.didMove(toParent: self)
        
        addChild(dashboardViewController)
        
        checkoutView.dashboardContainerView.wrapSubview(dashboardViewController.view)
        
        dashboardViewController.didMove(toParent: self)
        
    }
    
}
