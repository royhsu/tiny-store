//
//  UINewCheckoutItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UINewCheckoutItemView

public final class UINewCheckoutItemView: UIView {
    
    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {
        
        didSet {
            
            titleLabel.font = .preferredFont(forTextStyle: .body)
            
            titleLabel.adjustsFontForContentSizeCategory = true
            
            titleLabel.text = nil
            
            titleLabel.textColor = .black
            
        }
        
    }
    
    @IBOutlet
    private final weak var quantityStepperContainerView: UIView!
    
    public final let quantityStepper: UICheckoutStepper = {
        
        return UIView.loadView(
            UICheckoutStepper.self,
            from: Bundle(for: UICheckoutStepper.self)
        )!
        
    }()
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        quantityStepperContainerView.wrapSubview(quantityStepper)
        
    }
    
}
