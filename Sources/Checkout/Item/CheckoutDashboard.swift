//
//  CheckoutDashboard.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - CheckoutDashboard

public struct CheckoutDashboard {
    
    public let subTotal: Observable<Double>
    
    public let shipping: Observable<Double>
    
    public var payTotal: Double {
        
        let subTotal = self.subTotal.value ?? 0.0
        
        let shipping = self.shipping.value ?? 0.0
        
        return subTotal + shipping
        
    }
    
    public init(
        subTotal: Double = 0.0,
        shipping: Double = 0.0
    ) {
        
        self.subTotal = Observable(subTotal)
        
        self.shipping = Observable(shipping)
        
    }
    
}
