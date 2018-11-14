//
//  UICheckoutShippingServiceTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/14.
//

// MARK: - UICheckoutShippingServiceTemplate

public struct UICheckoutShippingServiceTemplate: CheckoutShippingServiceTemplate {
    
    private let serviceView = UIView.loadView(
        UICheckoutShippingServiceView.self,
        from: Bundle(for: UICheckoutShippingServiceView.self)
    )!
    
    private let views: [UIView]
    
    public let service: CheckoutShippingService
    
    public init(_ service: CheckoutShippingService) {
        
        self.service = service
        
        self.views = [ serviceView ]
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        serviceView.titleLabel.text = service.title.property.value
        
        let price = service.price.property.value ?? 0.0
        
        serviceView.priceLabel.text = "$ \(price)"
        
    }
    
    public var numberOfViews: Int { return views.count }
    
    public func view(at index: Int) -> View { return views[index] }
    
}
