//
//  UICheckoutDashboardButtonWrapperView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - UICheckoutDashboardButtonWrapperView

public final class UICheckoutDashboardButtonWrapperView: UIView {
    
    @IBOutlet
    public private(set) final weak var button: UIButton! {
        
        didSet {
            
            button.setTitle(
                "Button",
                for: .normal
            )
            
        }
        
    }
    
}
