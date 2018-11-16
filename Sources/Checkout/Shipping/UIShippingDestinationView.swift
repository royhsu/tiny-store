//
//  UIShippingDestinationView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - UIShippingDestinationView

public final class UIShippingDestinationView: UIView {
    
    @IBOutlet
    public private(set) final weak var recipientLabel: UILabel! {
        
        didSet {
            
            recipientLabel.adjustsFontForContentSizeCategory = true
            
            recipientLabel.font = .preferredFont(forTextStyle: .body)
            
            recipientLabel.numberOfLines = 1
            
            recipientLabel.text = nil
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var editButton: UIButton! {
        
        didSet {
            
            editButton.setTitle(
                NSLocalizedString(
                    "Edit",
                    comment: ""
                ),
                for: .normal
            )
            
            editButton.titleLabel?.adjustsFontForContentSizeCategory = true
            
            editButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
            
        }
        
    }
    
    @IBOutlet
    private final weak var cardView: UIView! {
        
        didSet {
            
            cardView.backgroundColor = .lightGray
            
            cardView.layer.cornerRadius = 3.0
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var cardTitleLabel: UILabel! {
        
        didSet {
            
            cardTitleLabel.adjustsFontForContentSizeCategory = true
            
            cardTitleLabel.font = .preferredFont(forTextStyle: .title3)
            
            cardTitleLabel.numberOfLines = 1
            
            cardTitleLabel.text = nil
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var cardAddressLabel: UILabel! {
        
        didSet {
            
            cardAddressLabel.adjustsFontForContentSizeCategory = true
            
            cardAddressLabel.font = .preferredFont(forTextStyle: .body)
            
            cardAddressLabel.numberOfLines = 0
            
            cardAddressLabel.text = nil
            
        }
        
    }
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = nil
        
    }
    
}
