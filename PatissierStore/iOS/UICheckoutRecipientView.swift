//
//  UICheckoutRecipientView.swift
//  PatissierStore
//
//  Created by Roy Hsu on 09/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutRecipientView

import TinyCore
import TinyKit
import UIKit

public final class UICheckoutRecipientView: UITableViewCell {

    @IBOutlet
    private final weak var buyerContentView: UIView!
    
    @IBOutlet
    private final weak var firstNameLabel: UILabel!
    
    @IBOutlet
    private final weak var firstNameContentView: UIView!
    
    @IBOutlet
    private final weak var firstNameBottomBorderView: UIView!

    @IBOutlet
    private final weak var firstNameTextField: UITextField!

    @IBOutlet
    private final weak var lastNameLabel: UILabel!

    @IBOutlet
    private final weak var lastNameContentView: UIView!

    @IBOutlet
    private final weak var lastNameBottomBorderView: UIView!

    @IBOutlet
    private final weak var lastNameTextField: UITextField!

    @IBOutlet
    private final weak var titleLabel: UILabel!

    @IBOutlet
    private final weak var titleContentView: UIView!

    @IBOutlet
    private final weak var titleBottomBorderView: UIView!

    @IBOutlet
    private final weak var titleLeftBorderView: UIView!

    @IBOutlet
    private final weak var titleRightBorderView: UIView!

    @IBOutlet
    private final weak var titleButton: UIButton!

    @IBOutlet
    private final weak var phoneNumberLabel: UILabel!

    @IBOutlet
    private final weak var phoneNumberContentView: UIView!

    @IBOutlet
    private final weak var phoneNumberBottomBorderView: UIView!

    @IBOutlet
    private final weak var phoneNumberTextField: UITextField!
    
    private final var isLoaded = false
    
    public final let actions = Observable<Action>()
    
    public final var recipient: CheckoutRecipient? {
        
        didSet { updateUI() }
        
    }
    
    fileprivate final func updateUI() {
        
        guard
            isLoaded
        else { return }
        
        firstNameTextField.text = recipient?.firstName
        
    }
    
    
//    public enum Element: CaseIterable {
//
//        case firstName, lastName, title, phoneNumber
//
//    }

//    public final var elements = Element.allCases {
//
//        didSet {
//
//            let isFirstNameHidden = !elements.contains(.firstName)
//
//            firstNameLabel.isHidden = isFirstNameHidden
//
//            firstNameContentView.isHidden = isFirstNameHidden
//
//            let isLastNameHidden = !elements.contains(.lastName)
//
//            lastNameLabel.isHidden = isLastNameHidden
//
//            lastNameContentView.isHidden = isLastNameHidden
//
//            let isTitleHidden = !elements.contains(.title)
//
//            titleLabel.isHidden = isTitleHidden
//
//            titleContentView.isHidden = isTitleHidden
//
//            let isPhoneNumberHidden = !elements.contains(.phoneNumber)
//
//            phoneNumberLabel.isHidden = isPhoneNumberHidden
//
//            phoneNumberContentView.isHidden = isPhoneNumberHidden
//
//        }
//
//    }
    
    public final override func awakeFromNib() {
        
        super.awakeFromNib()
        
        isLoaded.toggle()

        #warning("TODO: make the buyer button independent from this view.")
//        setUpContentView(buyerContentView)
        
        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            firstNameLabel,
            title: NSLocalizedString(
                "First Name",
                comment: ""
            )
        )
        
        setUpTextField(
            firstNameTextField,
            action: #selector(enterFirstName)
        )
        
        setUpContentView(firstNameContentView)
        
        setUpBorderView(firstNameBottomBorderView)

        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            lastNameLabel,
            title: NSLocalizedString(
                "Last Name",
                comment: ""
            )
        )
        
        setUpTextField(
            lastNameTextField,
            action: #selector(enterLastName)
        )
        
        setUpContentView(lastNameContentView)
        
        setUpBorderView(lastNameBottomBorderView)
        
        #warning("Should define a better key for localization")
        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            titleLabel,
            title: NSLocalizedString(
                "Title",
                comment: ""
            )
        )
        
        setUpActionButton(titleButton)
        
        setUpContentView(titleContentView)
        
        setUpBorderView(titleBottomBorderView)
        
        setUpBorderView(titleLeftBorderView)
        
        setUpBorderView(titleRightBorderView)
        
        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            phoneNumberLabel,
            title: NSLocalizedString(
                "Phone Number",
                comment: ""
            )
        )
        
        setUpTextField(
            phoneNumberTextField,
            action: #selector(enterPhoneNumber)
        )
        
        setUpContentView(phoneNumberContentView)
        
        setUpBorderView(phoneNumberBottomBorderView)
        
        updateUI()

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

        label.text = title

        label.textAlignment = .left

        #warning("TODO: should be defined in the design system.")
        label.textColor = UIColor(
            red: 165.0 / 255.0,
            green: 170.0 / 255.0,
            blue: 178.0 / 255.0,
            alpha: 1.0
        )

        label.text = title
        
    }
    
    fileprivate final func setUpContentView(_ view: UIView) { view.backgroundColor = .white }

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
    
    fileprivate final func setUpTextField(
        _ textField: UITextField,
        action: Selector
    ) {
        
        textField.borderStyle = .none
        
        textField.clearButtonMode = .whileEditing
        
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
            action: action,
            for: .editingChanged
        )
        
    }
    
    @objc
    public final func enterFirstName(_ textField: UITextField) {
        
        
        
    }
    
    @objc
    public final func enterLastName(_ textField: UITextField) {
        
        
        
    }

    @objc
    public final func enterPhoneNumber(_ textField: UITextField) {
        
        
        
    }
    
}
