//
//  TSShippingDestinationEditorRecipientNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorRecipientNibView

internal final class TSShippingDestinationEditorRecipientNibView: UIView {
    
    @IBOutlet
    internal private(set) final weak var stackView: UIStackView!
    
    @IBOutlet
    internal private(set) final weak var firstNameTextField: TSTextField! {
        
        didSet {
            
            firstNameTextField.placeholder = NSLocalizedString(
                "First Name",
                comment: ""
            )
            
        }
        
    }
    
    @IBOutlet
    internal private(set) final weak var lastNameTextField: TSTextField! {
        
        didSet {
            
            lastNameTextField.placeholder = NSLocalizedString(
                "Last Name",
                comment: ""
            )
            
        }
        
    }
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = nil
        
    }
    
}
