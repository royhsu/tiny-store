//
//  UINewCheckoutItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UINewCheckoutItemView

public final class UINewCheckoutItemView: UIView {
    
    @IBOutlet
    public private(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    private final weak var quantityStepperWrapperView: UIView!
    
    public final let quantityStepper: UICheckoutStepper = {
        
        return UIView.loadView(
            UICheckoutStepper.self,
            from: Bundle(for: UICheckoutStepper.self)
        )!
        
    }()
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        quantityStepperWrapperView.wrapSubview(quantityStepper)
        
    }
    
}
