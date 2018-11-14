//
//  UICheckoutShippingServiceTemplate.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/14.
//

// MARK: - UICheckoutShippingServiceTemplate

public final class UICheckoutShippingServiceTemplate: CheckoutShippingServiceTemplate {
    
    fileprivate final var observations: [Observation] = []
    
    private final let serviceView = UIView.loadView(
        UICheckoutShippingServiceView.self,
        from: Bundle(for: UICheckoutShippingServiceView.self)
    )!
    
    private final let views: [UIView]
    
    public final let service: CheckoutShippingService
    
    public init(_ service: CheckoutShippingService) {
        
        self.service = service
        
        self.views = [ serviceView ]
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        serviceView.isSelected = service.isSelected.property.value ?? true
        
        serviceView.isSelectedDidChange = { self.service.isSelected.property.value = $0 }

        // Broken.
//        observations.append(
//            service.isSelected.property.observe { change in
//
//                DispatchQueue.main.async {
//
//                    self.serviceView.isSelected = change.currentValue ?? false
//
//                }
//
//            }
//        )
        
        serviceView.titleLabel.text = service.title.property.value
        
        let price = service.price.property.value ?? 0.0
        
        serviceView.priceLabel.text = "$ \(price)"
        
    }
    
    public final var numberOfViews: Int { return views.count }
    
    public final func view(at index: Int) -> View { return views[index] }
    
}
