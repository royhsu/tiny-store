//
//  TSDashboardNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - TSDashboardNibView

#if canImport(UIKit)

internal final class TSDashboardNibView: UIView {
    
    @IBOutlet
    internal private(set) final weak var subTotalLabel: UILabel! {
        
        didSet {
            
            subTotalLabel.text = NSLocalizedString(
                "Subtotal",
                comment: ""
            )
            
        }
        
    }
    
    @IBOutlet
    internal private(set) final weak var subTotalPriceView: TSPriceView!
    
    @IBOutlet
    internal private(set) final weak var shippingLabel: UILabel! {
        
        didSet {
            
            shippingLabel.text = NSLocalizedString(
                "Shipping",
                comment: ""
            )
            
        }
        
    }
    
    @IBOutlet
    internal private(set) final weak var shippingPriceView: TSPriceView!
    
    @IBOutlet
    internal private(set) final weak var payTotalLabel: UILabel! {
        
        didSet {
            
            payTotalLabel.text = NSLocalizedString(
                "Pay Total",
                comment: ""
            )
            
        }
        
    }
    
    @IBOutlet
    internal private(set) final weak var payTotalPriceView: TSPriceView!
    
    internal final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        backgroundColor = nil
        
    }
    
}

#endif
