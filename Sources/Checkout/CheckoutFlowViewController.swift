//
//  CheckoutFlowViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutFlowViewController

public struct CheckoutFlowController {
    
    public enum State {
        
        case fillingOrder(CheckoutOrderViewController)
        
    }
    
    public private(set) var state: State
    
    internal let navigationController: NavigationController
 
    internal let orderController: CheckoutOrderViewController
    
    public init(
        navigation navigationType: NavigationController.Type,
        order orderType: CheckoutOrderViewController.Type
    ) {
        
        self.orderController = orderType.init()
        
        self.navigationController = navigationType.init(root: orderController)
        
        self.state = .fillingOrder(orderController)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        orderController.setOrder { result in
            
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
    
    public final var flowController: CheckoutFlowController? {
        
        didSet(oldFlowController) {
            
            guard
                isViewLoaded
            else { return }
            
            oldFlowController?.navigationController.willMove(toParent: nil)
            
            oldFlowController?.navigationController.view.removeFromSuperview()
            
            oldFlowController?.navigationController.removeFromParent()
            
            guard
                let newFlowController = flowController
            else { return }
                
            addChild(newFlowController.navigationController)
            
            view.wrapSubview(newFlowController.navigationController.view)
            
            newFlowController.navigationController.didMove(toParent: self)
            
        }
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard
            let flowController = flowController
        else { return }
        
        addChild(flowController.navigationController)
        
        view.wrapSubview(flowController.navigationController.view)
        
        flowController.navigationController.didMove(toParent: self)
        
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
