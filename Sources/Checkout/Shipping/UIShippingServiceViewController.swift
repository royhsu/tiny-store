//
//  UIShippingServiceViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - PriceFormatter

public protocol PriceFormatter {
    
    func string(from price: Double) -> String
    
}

// MARK: - DefaultPriceFormatter

internal struct DefaultPriceFormatter: PriceFormatter {
    
    internal func string(from price: Double) -> String { return "$ \(price)" }
    
}

// MARK: - UIShippingServiceViewController

#warning("Use Binding objects to replace the trivial implementation for updating.")
#warning("Generalize the view and make this controller generic and cross-platfrom compatible.")
public final class UIShippingServiceViewController: UIViewController {
    
    private final lazy var serviceView: UIShippingServiceView = {
        
        return UIView.loadView(
            UIShippingServiceView.self,
            from: Bundle(for: UIShippingServiceView.self)
        )!
    
    }()
    
    public final var service: ShippingService? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            renderView()
            
            observeModelChanges()
            
            handleViewActions()
            
        }
        
    }
    
    fileprivate final var observations: [Observation] = []
    
    fileprivate final var isSelectedUpdating = false
    
    fileprivate final var isTitleUpdating = false
    
    fileprivate final var isPriceUpdating = false
    
    public final var priceFormatter: PriceFormatter = DefaultPriceFormatter()
    
    public init(_ service: ShippingService? = nil) {
        
        self.service = service
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public final override func loadView() { view = serviceView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        renderView()
        
        observeModelChanges()
        
        handleViewActions()
        
    }
    
    fileprivate final func renderView() {
        
        guard let service = service else { return }
        
        serviceView.isSelected = service.isSelected.property.value ?? false
        
        serviceView.titleLabel.text = service.title.property.value
        
        let price = service.price.property.value ?? 0.0
        
        serviceView.priceLabel.text = priceFormatter.string(from: price)
        
    }
    
    fileprivate final func observeModelChanges() {
        
        guard let service = service else { return }
        
        observations = [
            service.isSelected.property.observe { [weak self] change in
                
                guard let self = self else { return }
                
                self.isSelectedUpdating = true
                
                self.serviceView.isSelected = change.currentValue ?? false
                
                self.isSelectedUpdating = false
                
            },
            service.title.property.observe { [weak self] change in
                
                guard let self = self else { return }
                
                self.isTitleUpdating = true
                
                self.serviceView.titleLabel.text = change.currentValue
                
                self.isTitleUpdating = false
                
            },
            service.price.property.observe { [weak self] change in
                
                guard
                    let self = self,
                    let service = self.service
                else { return }
                
                self.isPriceUpdating = true
                
                let price = service.price.property.value ?? 0.0
                
                self.serviceView.priceLabel.text = self.priceFormatter.string(from: price)
                
                self.isPriceUpdating = false
                
            }
        ]
        
    }
    
    fileprivate final func handleViewActions() {
        
        serviceView.isSelectedDidChange = { [weak self] in
            
            guard
                let self = self,
                let service = self.service
            else { return }
            
            if self.isSelectedUpdating { return }
            
            service.isSelected.property.value = $0
            
        }
        
    }
    
}
