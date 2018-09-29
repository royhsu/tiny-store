//
//  CheckoutFlow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlow

public struct CheckoutFlow {
    
    public enum Step {
        
        case fillingOrder(OrderStep)
        
    }
    
    public private(set) var step: Step
    
    public typealias Navigation = NavigationController
    
    private let navigation: Navigation
    
    public typealias OrderStep = CheckoutOrderStep & ViewController
 
    private let orderStep: OrderStep
    
    public var viewController: ViewController { return navigation }
    
    public init(
        navigation navigationType: NavigationController.Type,
        firstStep: OrderStep
    ) {
        
        self.orderStep = firstStep
        
        self.navigation = navigationType.init(root: firstStep)
        
        self.step = .fillingOrder(firstStep)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        orderStep.setOrder { result in
            
            switch result {
                
            case let .success(order):
                
                print("Process order...\n", order)
                
            case let .failure(error):
                
                #warning("error handling.")
                
                print("\(error)")
                
            }
            
        }
        
    }
    
}

public final class CheckoutFlowViewController: ViewController {
    
    public final var flow: CheckoutFlow? {
        
        didSet(oldFlow) {
            
            guard
                isViewLoaded
            else { return }
            
            oldFlow?.viewController.willMove(toParent: nil)
            
            oldFlow?.viewController.view.removeFromSuperview()
            
            oldFlow?.viewController.removeFromParent()
            
            guard
                let newFlow = flow
            else { return }
                
            addChild(newFlow.viewController)
            
            view.wrapSubview(newFlow.viewController.view)
            
            newFlow.viewController.didMove(toParent: self)
            
        }
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard
            let flow = flow
        else { return }
        
        addChild(flow.viewController)
        
        view.wrapSubview(flow.viewController.view)
        
        flow.viewController.didMove(toParent: self)
        
    }
    
}

import UIKit

public final class NavigationController: UINavigationController {
    
    public required convenience init(root: ViewController) { self.init(rootViewController: root) }
    
    public func push(_ child: ViewController) {
        
        self.pushViewController(
            child,
            animated: true
        )
        
    }

}
