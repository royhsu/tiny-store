//
//  CheckoutOrder.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CheckoutOrder

public protocol CheckoutOrderController {
    
    var form: CheckoutForm { get set }
    
    #warning("bad naming.")
    func navigate(
        _ navigation: @escaping (Destination) -> Void
    )
    
    func setOrder(
        _ completion: @escaping (Result<CheckoutOrder>) -> Void
    )
    
}

// MARK: - CheckoutOrderViewController

public typealias CheckoutOrderViewController = CheckoutOrderController & ViewController
