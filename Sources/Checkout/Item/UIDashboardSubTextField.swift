//
//  UIDashboardSubTextField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UIDashboardSubTextField

public final class UIDashboardSubTextField: UIView {
    
    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {
        
        didSet {
            
            titleLabel.adjustsFontForContentSizeCategory = true
            
            titleLabel.font = .preferredFont(forTextStyle: .body)
            
            titleLabel.numberOfLines = 1
            
            titleLabel.text = "Title"
            
            titleLabel.textColor = .lightGray
            
        }
        
    }
    
    @IBOutlet
    public private(set) final weak var amountLabel: UILabel! {
        
        didSet {
            
            amountLabel.adjustsFontForContentSizeCategory = true
            
            amountLabel.adjustsFontSizeToFitWidth = true
            
            amountLabel.font = .preferredFont(forTextStyle: .body)
            
            amountLabel.numberOfLines = 1
            
            amountLabel.text = "$ 0"
            
            amountLabel.textColor = .black
            
        }
        
    }
    
    public final override func awakeFromNib() {
    
        super.awakeFromNib()
        
        backgroundColor = .clear
        
    }
    
}
