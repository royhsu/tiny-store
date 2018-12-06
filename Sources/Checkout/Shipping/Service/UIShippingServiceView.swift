//
//  UIShippingServiceView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - UIShippingServiceView

public final class UIShippingServiceView: UIView {
    
    @IBOutlet
    private final weak var selectionView: UICheckoutSelectionView! {
        
        didSet {
            
            selectionView.tintColor = .black
            
            selectionView.didReceiveUserInput = { [weak self] isSelected in
                
                self?.isSelectedDidChange?(isSelected)
                
            }
            
        }
        
    }
    
    public final var isSelected: Bool {
        
        get { return selectionView.isSelected }
        
        set { selectionView.isSelected = newValue }
        
    }
    
    public final var isSelectedDidChange: ( (Bool?) -> Void )?
    
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
    public private(set) final weak var priceLabel: UILabel! {
        
        didSet {
            
            priceLabel.adjustsFontForContentSizeCategory = true
            
            priceLabel.font = .preferredFont(forTextStyle: .body)
            
            priceLabel.adjustsFontSizeToFitWidth = true
            
            priceLabel.text = nil
            
            priceLabel.textAlignment = .right
            
        }
        
    }
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = nil
        
    }
    
}
