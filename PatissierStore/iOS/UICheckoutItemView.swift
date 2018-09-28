//
//  UICheckoutItemView.swift
//  PatissierStore
//
//  Created by Roy Hsu on 2018/9/28.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutItemView

public final class UICheckoutItemView: UIView, Actionable {
    
    @IBOutlet
    private final weak var previewImageView: UIImageView!
    
    @IBOutlet
    private final weak var titleLabel: UILabel!
    
    @IBOutlet
    private final weak var priceLabel: UILabel!
    
    @IBOutlet
    private final weak var quantityStepper: UIStepper!
    
    @IBOutlet
    private final weak var quantityLabel: UILabel!
    
    private final var isLoaded = false
    
    public final let actions = Observable<Action>()
    
    public final var itemField: CheckoutItemField? {
        
        didSet { updateUI() }
        
    }
    
    fileprivate final func updateUI() {
        
        guard
            isLoaded
        else { return }
        
    }
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        isLoaded.toggle()
        
        setUpTitleLabel(titleLabel)
        
        setUpPriceLabel(priceLabel)
        
        setUpQuantityLabel(quantityLabel)
        
        setUpQuantityStepper(quantityStepper)
        
        updateUI()
        
    }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        #warning("TODO: should be defined in the design system.")
        label.font = UIFont(
            name: "Georgia",
            size: 14.0
        )
        
        label.numberOfLines = 2
        
        label.text = nil
    
        label.textAlignment = .left
        
        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
    }
    
    fileprivate final func setUpPriceLabel(_ label: UILabel) {
        
        #warning("TODO: should be defined in the design system.")
        label.font = UIFont(
            name: "LuxiMono",
            size: 12.0
        )
        
        label.numberOfLines = 1
        
        label.text = nil
        
        label.textAlignment = .left
        
        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
    }
    
    fileprivate final func setUpQuantityLabel(_ label: UILabel) {
        
        #warning("TODO: should be defined in the design system.")
        label.font = UIFont(
            name: "LuxiMono",
            size: 24.0
        )
        
        label.numberOfLines = 1
        
        label.text = nil
        
        label.textAlignment = .right
        
        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
    }
    
    fileprivate final func setUpQuantityStepper(_ stepper: UIStepper) {
        
        #warning("TODO: should be defined in the design system.")
        stepper.tintColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
        #warning("stepper size.")
        
    }
    
}
