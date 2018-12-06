//
//  UICheckoutCartItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/10/31.
//

// MARK: - UICheckoutCartItemView

public final class UICheckoutCartItemView: UIView, UserInputable {
    
    @IBOutlet
    private final weak var selectionView: UICheckoutSelectionView! {
        
        didSet { selectionView.tintColor = .black }
        
    }
    
    public final var isSelected: Bool {
        
        get { return selectionView.isSelected }
        
        set { selectionView.isSelected = newValue }
        
    }
    
    #warning("should find a better way to propagate input values from subviews.")
    public final var didReceiveUserInput: ( (Bool) -> Void )? {
        
        get { return selectionView.didReceiveUserInput }
        
        set {
            
            selectionView.didReceiveUserInput = { [weak self] isSelected in
                
                self?.contentStackView.alpha = isSelected ? 1.0 : 0.5
                
                newValue?(isSelected)
                
            }
            
        }
        
    }
    
    @IBOutlet
    private final weak var contentStackView: UIStackView!
    
    @IBOutlet
    public private(set) final weak var previewImageView: UIImageView! {
        
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
            
            descriptionLabel.font = .preferredFont(forTextStyle: .caption1)
            
            descriptionLabel.numberOfLines = 0
            
            descriptionLabel.text = nil
            
            descriptionLabel.textColor = .darkGray
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var priceView: UICheckoutPriceView!
    
    @IBOutlet
    private final weak var quantityStepperContainerView: UIView! {
        
        didSet { quantityStepperContainerView.backgroundColor = nil }
        
    }
    
    public final let quantityStepper: UICheckoutStepper = {
        
        let stepper = UIView.loadView(
            UICheckoutStepper.self,
            from: Bundle(for: UICheckoutStepper.self)
        )!
        
        stepper.tintColor = .black
        
        return stepper
        
    }()
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        quantityStepperContainerView.wrapSubview(quantityStepper)
        
        contentStackView.alpha = isSelected ? 1.0 : 0.5
        
    }
    
}

// MARK: - ValueRenderable

#warning("a temporary fix before solving the propagate issue above.")
extension UICheckoutCartItemView: ValueRenderable {
    
    public final func render(with isSelected: Bool?) {
        
        if let isSelected = isSelected { contentStackView.alpha = isSelected ? 1.0 : 0.5 }
         
        selectionView.render(with: isSelected)
        
    }
    
}
