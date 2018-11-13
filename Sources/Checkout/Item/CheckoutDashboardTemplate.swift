//
//  CheckoutDashboardTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutDashboardTemplate

public final class UICheckoutDashboardTemplate: Template {
    
    private final let subTotalField: UICheckoutDashboardSubField = {
        
        let field = UIView.loadView(
            UICheckoutDashboardSubField.self,
            from: Bundle(for: UICheckoutDashboardSubField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "SubTotal",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let subTotalFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let subTotalFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let shippingField: UICheckoutDashboardSubField = {
        
        let field = UIView.loadView(
            UICheckoutDashboardSubField.self,
            from: Bundle(for: UICheckoutDashboardSubField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "Shipping",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let shippingFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let shippingFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let payTotalField: UICheckoutDashboardMainField = {
        
        let field = UIView.loadView(
            UICheckoutDashboardMainField.self,
            from: Bundle(for: UICheckoutDashboardMainField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "Pay Total",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let payTotalFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 16.0) ]
        )
        
        return view
        
    }()
    
    private final let payTotalFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )
        
        return view
        
    }()
    
    private final let checkoutButtonWrapperView: UICheckoutDashboardButtonWrapperView = {
        
        let view = UIView.loadView(
            UICheckoutDashboardButtonWrapperView.self,
            from: Bundle(for: UICheckoutDashboardButtonWrapperView.self)
        )!
        
        let buttonTitle = NSLocalizedString(
            "Checkout",
            comment: ""
        )
        
        view.button.setTitle(
            buttonTitle + " →",
            for: .normal
        )
        
        return view
        
    }()
    
    private final var views: [UIView] {
        
        return [
            subTotalFieldTopMarginView,
            subTotalField,
            subTotalFieldBottomMarginView,
            shippingFieldTopMarginView,
            shippingField,
            shippingFieldBottomMarginView,
            payTotalFieldTopMarginView,
            payTotalField,
            payTotalFieldBottomMarginView,
            checkoutButtonWrapperView
        ]
        
    }
    
    fileprivate final var observations: [Observation] = []
    
    private final let dashboard: CheckoutDashboard
    
    public init(dashboard: CheckoutDashboard) {
        
        self.dashboard = dashboard
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        let subTotal = dashboard.subTotal.value ?? 0.0
        
        subTotalField.amountLabel.text = "$ \(subTotal)"
        
        payTotalField.amountLabel.text = "$ \(subTotal)"
        
        observations.append(
            dashboard.subTotal.observe { [weak self] change in
                
                DispatchQueue.main.async {
                
                    let subTotal = change.currentValue ?? 0.0
                    
                    self?.subTotalField.amountLabel.text = "$ \(subTotal)"
                    
                    let payTotal = self?.dashboard.payTotal ?? 0.0
                    
                    self?.payTotalField.amountLabel.text = "$ \(payTotal)"
                    
                }
                
            }
        )
        
        observations.append(
            dashboard.shipping.observe { [weak self] change in
                
                DispatchQueue.main.async {
                    
                    let shipping = change.currentValue ?? 0.0
                    
                    self?.shippingField.amountLabel.text = "$ \(shipping)"
                    
                    let payTotal = self?.dashboard.payTotal ?? 0.0
                    
                    self?.payTotalField.amountLabel.text = "$ \(payTotal)"
                    
                }
                
            }
        )
        
    }
    
    public final var numberOfViews: Int { return views.count }
    
    public final func view(at index: Int) -> View { return views[index] }
    
}
