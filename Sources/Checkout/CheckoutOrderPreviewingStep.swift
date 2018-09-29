//
//  CheckoutOrderPreviewingStep.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/29.
//

// MARK: - CheckoutOrderPreviewingStep

public protocol CheckoutOrderPreviewingStep {
    
    func makeOrder(
        _ completion: @escaping (Result<Void>) -> Void
    )
    
}
