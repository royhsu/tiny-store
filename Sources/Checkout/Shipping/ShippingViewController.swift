//
//  ShippingViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - ShippingViewController

public final class ShippingViewController: ViewController {
    
    private final let serviceListViewController = ShippingServiceListViewController()
    
    public final var serviceList: ShippingServiceList { return serviceListViewController.list }
    
    private final let destinationWrapperView = View()
    
    public final var destination: ShippingDestination? {
        
        get { return _destinationViewController.destination }
        
        set(newDestination) {
            
            _destinationViewController.destination = newDestination
            
            guard isViewLoaded else { return }
            
            destinationWrapperViewHeightConstraint.isActive = (newDestination == nil)
            
        }
        
    }
    
    public final var editDestination: ( () -> Void )? {
        
        get { return _destinationViewController.edit }
        
        set { _destinationViewController.edit = newValue }
        
    }
    
    private final lazy var _destinationViewController: UIShippingDestinationViewController = {
        
        let controller = UIShippingDestinationViewController()
        
        return controller
        
    }()
    
    private final lazy var destinationWrapperViewHeightConstraint: NSLayoutConstraint = {
        
        return destinationWrapperView.heightAnchor.constraint(equalToConstant: 0.0)
        
    }()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        destinationWrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(destinationWrapperView)
        
        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: destinationWrapperView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: destinationWrapperView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: destinationWrapperView.bottomAnchor)
            ]
        )
        
        destinationWrapperViewHeightConstraint.isActive = (destination == nil)
        
        addChild(_destinationViewController)
        
        destinationWrapperView.wrapSubview(_destinationViewController.view)
        
        _destinationViewController.didMove(toParent: self)
        
        addChild(serviceListViewController)
        
        let serviceListView = serviceListViewController.view!
        
        serviceListView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(serviceListView)
        
        let verticalConnectionConstraint: NSLayoutConstraint
        
        if #available(iOS 11.0, *) {
            
            verticalConnectionConstraint = destinationWrapperView.topAnchor.constraint(
                equalToSystemSpacingBelow: serviceListView.bottomAnchor,
                multiplier: 1.0
            )
            
        }
        else {
            
            verticalConnectionConstraint = destinationWrapperView.topAnchor.constraint(
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
