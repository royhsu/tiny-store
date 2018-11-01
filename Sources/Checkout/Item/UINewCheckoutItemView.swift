//
//  UINewCheckoutItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UINewCheckoutItemView

public final class UINewCheckoutItemView: UIView {
    
    @IBOutlet
    public private(set) weak var previewImageView: UIImageView! {
        
        didSet {
            
            previewImageView.backgroundColor = .lightGray
            
            previewImageView.contentMode = .scaleAspectFill
            
            previewImageView.layer.borderColor = UIColor.darkGray.cgColor
            
            previewImageView.layer.borderWidth = 0.5
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {
        
        didSet {
            
            titleLabel.adjustsFontForContentSizeCategory = true
            
            titleLabel.font = .preferredFont(forTextStyle: .body)
            
            titleLabel.numberOfLines = 0
            
            titleLabel.text = nil
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var descriptionLabel: UILabel! {
        
        didSet {
            
            descriptionLabel.adjustsFontForContentSizeCategory = true
            
            descriptionLabel.font = .preferredFont(forTextStyle: .body)
            
            descriptionLabel.numberOfLines = 0
            
            descriptionLabel.text = nil
            
            descriptionLabel.textColor = .darkGray
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var priceLabel: UILabel! {
        
        didSet {
            
            priceLabel.adjustsFontForContentSizeCategory = true
            
            priceLabel.font = .preferredFont(forTextStyle: .body)
            
            priceLabel.text = nil
            
            priceLabel.textAlignment = .right
            
        }
        
    }
    
    @IBOutlet
    private final weak var quantityStepperContainerView: UIView! {
        
        didSet {
            
            quantityStepperContainerView.backgroundColor = nil
            
        }
        
    }
    
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
