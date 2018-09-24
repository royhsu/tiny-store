//
//  CheckoutShippingView.swift
//  Patissier
//
//  Created by Roy Hsu on 09/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - CheckoutShippingView

import UIKit

public final class CheckoutShippingView: UIView {

    @IBOutlet
    private final weak var cityLabel: UILabel!

    @IBOutlet
    private final weak var cityContentView: UIView!

    @IBOutlet
    private final weak var cityBottomBorderView: UIView!

    @IBOutlet
    private final weak var cityLeftBorderView: UIView!

    @IBOutlet
    private final weak var cityRightBorderView: UIView!

    @IBOutlet
    private(set) final weak var cityButton: UIButton!

    @IBOutlet
    private final weak var postalCodeLabel: UILabel!

    @IBOutlet
    private final weak var postalCodeContentView: UIView!

    @IBOutlet
    private final weak var postalCodeBottomBorderView: UIView!

    @IBOutlet
    private final weak var postalCodeLeftBorderView: UIView!

    @IBOutlet
    private final weak var postalCodeRightBorderView: UIView!

    @IBOutlet
    private(set) final weak var postalCodeButton: UIButton!

    @IBOutlet
    private final weak var addressLabel: UILabel!

    @IBOutlet
    private final weak var addressContentView: UIView!

    @IBOutlet
    private final weak var addressBottomBorderView: UIView!

    @IBOutlet
    private(set) final weak var addressTextField: UITextField!
    
    public typealias ActionHandler = (CheckoutShippingAction) -> Void
    
    public final var actionHandler: ActionHandler?

    public final override func awakeFromNib() {
        
        super.awakeFromNib()

        setUpContentView(cityContentView)

        setUpBorderView(cityBottomBorderView)
        
        setUpBorderView(cityLeftBorderView)
        
        setUpBorderView(cityRightBorderView)
        
        setUpTitleLabel(
            cityLabel,
            title: NSLocalizedString(
                "City",
                comment: ""
            )
        )

        setUpActionButton(cityButton)

        setUpContentView(postalCodeContentView)

        setUpBorderView(postalCodeBottomBorderView)
        
        setUpBorderView(postalCodeLeftBorderView)
        
        setUpBorderView(postalCodeRightBorderView)
        
        setUpTitleLabel(
            postalCodeLabel,
            title: NSLocalizedString(
                "Postal Code",
                comment: ""
            )
        )

        setUpActionButton(postalCodeButton)

        setUpContentView(addressContentView)
        
        setUpBorderView(addressBottomBorderView)
    
        setUpTitleLabel(
            addressLabel,
            title: NSLocalizedString(
                "Address",
                comment: ""
            )
        )

        setUpTextField(addressTextField)

    }

    // MARK: Set Up

    fileprivate final func setUpContentView(_ view: UIView) {

        #warning("TODO: should be defined in the design system.")
        view.backgroundColor = .white

    }
    
    fileprivate final func setUpBorderView(_ view: UIView) {
        
        #warning("TODO: should be defined in the design system.")
        let borderColor = UIColor(
            red: 165.0 / 255.0,
            green: 170.0 / 255.0,
            blue: 178.0 / 255.0,
            alpha: 1.0
        )

        view.backgroundColor = borderColor
        
    }

    fileprivate final func setUpTitleLabel(
        _ label: UILabel,
        title: String
    ) {

        #warning("TODO: should be defined in the design system.")
        label.font = UIFont(
            name: "Georgia",
            size: 12.0
        )

        label.numberOfLines = 1
    
        label.textAlignment = .left

        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 165.0 / 255.0,
            green: 170.0 / 255.0,
            blue: 178.0 / 255.0,
            alpha: 1.0
        )

    }

    fileprivate final func setUpActionButton(_ button: UIButton) {

        button.contentEdgeInsets = UIEdgeInsets(
            top: 10.0,
            left: 5.0,
            bottom: 5.0,
            right: 5.0
        )

        button.setTitle(
            nil,
            for: .normal
        )

        button.titleLabel?.textAlignment = .center

        #warning("TODO: should be defined in the design system.")
        button.titleLabel?.font = .systemFont(ofSize: 16.0)

        #warning("TODO: should be defined in the design system.")
        button.tintColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )

    }

    fileprivate final func setUpTextField(_ textField: UITextField) {

        textField.borderStyle = .none

        textField.clearButtonMode = .whileEditing

//        textField.field = .address

        #warning("TODO: should be defined in the design system.")
        textField.font = .systemFont(ofSize: 16.0)

        textField.text = nil

        textField.textAlignment = .left

        #warning("TODO: should be defined in the design system.")
        textField.textColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )

        #warning("TODO: should be defined in the design system.")
        textField.tintColor = UIColor(
            red: 82.0 / 255.0,
            green: 66.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 1.0
        )
        
        textField.addTarget(
            self,
            action: #selector(enterAddress),
            for: .editingChanged
        )

    }
    
    @objc
    public final func enterAddress(_ textField: UITextField) {
        
        actionHandler?(
            .newInput(.address(textField.text))
        )
        
    }

}
