//
//  ShippingController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - ShippingController

public final class ShippingController: ViewController {
    
    private final let destinationWrapperView = View()
    
    public final var destination: ShippingDestination? {
        
        get { return _destinationViewController.destination }
        
        set(newDestination) {
            
            _destinationViewController.destination = newDestination
            
            guard isViewLoaded else { return }
            
            destinationWrapperViewHeightConstraint.isActive = (newDestination == nil)
            
        }
        
    }
    
    private final let _destinationViewController = UIShippingDestinationViewController()
    
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
        
    }
    
}
