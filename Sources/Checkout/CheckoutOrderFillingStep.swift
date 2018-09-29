//
//  CheckoutOrderFillingStep.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/29.
//

// MARK: - CheckoutOrderFillingStep

public protocol CheckoutOrderFillingStep {
    
    func fillOutOrder(
        _ completion: @escaping (Result<CheckoutOrder>) -> Void
    )
    
}
