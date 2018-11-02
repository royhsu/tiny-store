//
//  CheckoutDashboardTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutDashboardTemplate

public struct UICheckoutDashboardTemplate: Template {
    
    private let subTotalField: UICheckoutDashboardSubField = {
        
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
    
    private let subTotalFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private let subTotalFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private let shippingField: UICheckoutDashboardSubField = {
        
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
    
    private let shippingFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private let shippingFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 2.0) ]
        )
        
        return view
        
    }()
    
    private let payTotalField: UICheckoutDashboardMainField = {
        
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
    
    private let payTotalFieldTopMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 16.0) ]
        )
        
        return view
        
    }()
    
    private let payTotalFieldBottomMarginView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )
        
        return view
        
    }()
    
    private let checkoutButtonWrapperView: UICheckoutDashboardButtonWrapperView = {
        
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
    
    private var views: [UIView] {
        
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
    
    public init() { }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
