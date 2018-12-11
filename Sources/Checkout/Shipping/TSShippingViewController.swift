//
//  TSShippingViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - TSShippingViewController

public final class TSShippingViewController: ViewController {
    
    public private(set) final lazy var serviceListViewController: ShippingServiceListViewController = { return ShippingServiceListViewController() }()
    
    private final let destinationCardWrapperView = View()
    
    public private(set) final lazy var destinationCardViewController: TSShippingDestinationCardViewController = { return TSShippingDestinationCardViewController() }()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        destinationCardWrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(destinationCardWrapperView)
        
        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: destinationCardWrapperView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: destinationCardWrapperView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: destinationCardWrapperView.bottomAnchor)
            ]
        )
        
        addChild(destinationCardViewController)
        
        destinationCardWrapperView.wrapSubview(destinationCardViewController.view)
        
        destinationCardViewController.didMove(toParent: self)
        
        addChild(serviceListViewController)
        
        let serviceListView = serviceListViewController.view!
        
        serviceListView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(serviceListView)
        
        let verticalConnectionConstraint: NSLayoutConstraint
        
        if #available(iOS 11.0, *) {
            
            verticalConnectionConstraint = destinationCardWrapperView.topAnchor.constraint(
                equalToSystemSpacingBelow: serviceListView.bottomAnchor,
                multiplier: 1.0
            )
            
        }
        else {
            
            verticalConnectionConstraint = destinationCardWrapperView.topAnchor.constraint(
                equalTo: serviceListView.bottomAnchor,
                constant: 8.0
            )
            
        }
        
        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: serviceListView.leadingAnchor),
                view.topAnchor.constraint(equalTo: serviceListView.topAnchor),
                view.trailingAnchor.constraint(equalTo: serviceListView.trailingAnchor),
                verticalConnectionConstraint
            ]
        )
        
        serviceListViewController.didMove(toParent: self)
        
    }
    
}
