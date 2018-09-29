//
//  CheckoutFlow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlowController

public final class CheckoutFlowController: ViewController {
    
    public enum Step {
        
        case makeOrder(OrderStepViewController)
        
        case end(ViewController)
        
        var viewController: ViewController {
            
            switch self {
                
            case let .makeOrder(controller): return controller
                
            case let .end(controller): return controller
                
            }
            
        }
        
    }
    
    /// A flow shouldn't be interrupted after it gets started.
    /// Please make sure to check this value before an operation tries to do so.
    public final var isFlowRunning: Bool { return (step != nil) }
    
    private final var step: Step? {
        
        willSet(newStep) {
            
            if
                isFlowRunning,
                newStep != nil
            { fatalError("The flow is running and shouldn't be interrupted.") }
            
        }
        
        didSet {
            
            switch step {
                
            case let .makeOrder(viewController)?:
                
                viewController.makeOrder { result in
                    
                    switch result {
                        
                    case let .success(order):
                        
                        print("Process order...\n", order)
                        
                    case let .failure(error):
                        
                        #warning("error handling.")
                        
                        print("\(error)")
                        
                    }
                    
                }
                
                base.setViewControllers(
                    [ viewController ],
                    animated: true
                )
                
            case let .end(viewController)?:
                
                base.pushViewController(
                    viewController,
                    animated: true
                )
                
            case .none:
                
                base.setViewControllers(
                    [ plainViewController ],
                    animated: true
                )
                
            }
            
        }
        
    }
    
    public typealias OrderStepViewController = CheckoutOrderStep & ViewController
    
    public final var orderViewController: OrderStepViewController? {
        
        didSet { startFlowIfAvailable() }
        
    }
    
    fileprivate final let plainViewController: ViewController = {
     
        let viewController = ViewController()
        
        viewController.view.backgroundColor = .white
        
        return viewController
        
    }()
    
    /// The base.
    private final lazy var base: NavigationController = { return NavigationController(rootViewController: plainViewController) }()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(base)

        view.wrapSubview(base.view)

        base.didMove(toParent: self)
        
        startFlowIfAvailable()
        
    }
    
    fileprivate final func startFlowIfAvailable() {
        
        guard
            isViewLoaded,
            !isFlowRunning,
            let firstStep = firstStep()
        else { return }
        
        step = firstStep
        
    }
    
    fileprivate final func firstStep() -> Step? {
        
        guard
            let orderViewController = orderViewController
        else { return nil }
        
        return .makeOrder(orderViewController)
        
    }
    
}

// MARK: - NavigationController

import UIKit

public typealias NavigationController = UINavigationController
