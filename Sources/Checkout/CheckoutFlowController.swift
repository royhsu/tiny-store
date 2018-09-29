//
//  CheckoutFlow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlowController

public final class CheckoutFlowController: ViewController {
    
    public enum Step {
        
        case fillingOrder(OrderStepViewController)
        
        var viewController: ViewController {
            
            switch self {
                
            case let .fillingOrder(controller): return controller
                
            }
            
        }
        
    }
    
    public private(set) var step: Step? {
        
        didSet {
            
            switch step {
                
            case let .fillingOrder(viewController)?:
                
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
        
        didSet { startFlowIfStepsReady() }
        
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
        
        startFlowIfStepsReady()
        
    }
    
    fileprivate final func startFlowIfStepsReady() {
        
        guard
            isViewLoaded,
            let firstStep = firstStep()
        else { return }
        
        step = firstStep
        
    }
    
    fileprivate final func firstStep() -> Step? {
        
        guard
            let orderViewController = orderViewController
        else { return nil }
        
        return .fillingOrder(orderViewController)
        
    }
    
}

// MARK: - NavigationController

import UIKit

public typealias NavigationController = UINavigationController
