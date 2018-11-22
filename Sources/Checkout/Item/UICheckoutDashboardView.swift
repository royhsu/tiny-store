//
//  UICheckoutDashboardView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardView

public final class UICheckoutDashboardView: Template {
    
    private final let subTotalTextField: UIDashboardSubTextField = {
        
        let field = UIView.loadView(
            UIDashboardSubTextField.self,
            from: Bundle(for: UIDashboardSubTextField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "SubTotal",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let subTotalTextFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let subTotalTextFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let shippingTextField: UIDashboardSubTextField = {
        
        let field = UIView.loadView(
            UIDashboardSubTextField.self,
            from: Bundle(for: UIDashboardSubTextField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "Shipping",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let shippingTextFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let shippingTextFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private final let payTotalTextField: UICheckoutDashboardMainTextField = {
        
        let field = UIView.loadView(
            UICheckoutDashboardMainTextField.self,
            from: Bundle(for: UICheckoutDashboardMainTextField.self)
        )!
        
        field.titleLabel.text = NSLocalizedString(
            "Pay Total",
            comment: ""
        )
        
        return field
        
    }()
    
    private final let payTotalTextFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 16.0) ]
        )
        
        return view
        
    }()
    
    private final let payTotalTextFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )
        
        return view
        
    }()
    
    private final lazy var checkoutButtonWrapperView: UICheckoutDashboardButtonWrapperView = {
        
        let view = UIView.loadView(
            UICheckoutDashboardButtonWrapperView.self,
            from: Bundle(for: UICheckoutDashboardButtonWrapperView.self)
        )!
        
        view.button.addTarget(
            self,
            action: #selector(action),
            for: .touchUpInside
        )
        
        return view
        
    }()
    
    private final var views: [UIView] {
        
        return [
            subTotalTextFieldTopMarginView,
            subTotalTextField,
            subTotalTextFieldBottomMarginView,
            shippingTextFieldTopMarginView,
            shippingTextField,
            shippingTextFieldBottomMarginView,
            payTotalTextFieldTopMarginView,
            payTotalTextField,
            payTotalTextFieldBottomMarginView,
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
        
        subTotalTextField.amountLabel.text = "$ \(subTotal)"
        
        payTotalTextField.amountLabel.text = "$ \(subTotal)"
        
        observations.append(
            dashboard.subTotal.observe { [weak self] change in
                
                DispatchQueue.main.async {
                
                    let subTotal = change.currentValue ?? 0.0
                    
                    self?.subTotalTextField.amountLabel.text = "$ \(subTotal)"
                    
                    let payTotal = self?.dashboard.payTotal ?? 0.0
                    
                    self?.payTotalTextField.amountLabel.text = "$ \(payTotal)"
                    
                }
                
            }
        )
        
        observations.append(
            dashboard.shipping.observe { [weak self] change in
                
                DispatchQueue.main.async {
                    
                    let shipping = change.currentValue ?? 0.0
                    
                    self?.shippingTextField.amountLabel.text = "$ \(shipping)"
                    
                    let payTotal = self?.dashboard.payTotal ?? 0.0
                    
                    self?.payTotalTextField.amountLabel.text = "$ \(payTotal)"
                    
                }
                
            }
        )
        
    }
    
    public final var numberOfViews: Int { return views.count }
    
    public final func view(at index: Int) -> View { return views[index] }

    fileprivate final var _actionHandler: ( () -> Void )?
    
    public final func setAction(
        title: String,
        handler: @escaping () -> Void
    ) {

        checkoutButtonWrapperView.button.setTitle(
            title,
            for: .normal
        )

        _actionHandler = handler

    }
    
    @objc
    public final func action(_ sender: Any) { _actionHandler?() }
    
}
