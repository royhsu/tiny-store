//
//  UICheckoutRecipientView.swift
//  PatissierStore
//
//  Created by Roy Hsu on 09/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutRecipientView

public final class UICheckoutRecipientView: UIView, Actionable {

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
    private final weak var personTitleLabel: UILabel!

    @IBOutlet
    private final weak var personTitleContentView: UIView!

    @IBOutlet
    private final weak var personTitleBottomBorderView: UIView!

    @IBOutlet
    private final weak var personTitleLeftBorderView: UIView!

    @IBOutlet
    private final weak var personTitleRightBorderView: UIView!

    @IBOutlet
    private final weak var personTitleButton: UIButton!

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

    public final var recipientField: CheckoutRecipientField? {

        didSet { updateUI() }

    }

    fileprivate final func updateUI() {

        guard
            isLoaded
        else { return }

        firstNameTextField.text = recipientField?.firstNameField.value
        
        lastNameTextField.text = recipientField?.lastNameField.value
        
        personTitleButton.setTitle(
            recipientField?.personTitleField.value,
            for: .normal
        )
        
        phoneNumberTextField.text = recipientField?.phoneNumberField.value

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        isLoaded.toggle()

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
            action: #selector(updateFirstName)
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
            action: #selector(updateLastName)
        )

        setUpContentView(lastNameContentView)

        setUpBorderView(lastNameBottomBorderView)

        #warning("Should define a better key for localization")
        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            personTitleLabel,
            title: NSLocalizedString(
                "Title",
                comment: ""
            )
        )

        setUpActionButton(
            personTitleButton,
            action: #selector(showPersonTitlePicker)
        )

        setUpContentView(personTitleContentView)

        setUpBorderView(personTitleBottomBorderView)

        setUpBorderView(personTitleLeftBorderView)

        setUpBorderView(personTitleRightBorderView)

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
            action: #selector(updatePhoneNumber)
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

    fileprivate final func setUpActionButton(
        _ button: UIButton,
        action: Selector
    ) {

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
        
        button.addTarget(
            self,
            action: action,
            for: .touchUpInside
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
    public final func updateFirstName(_ textField: UITextField) {
        
        recipientField?.firstNameField.value = textField.text
        
        guard
            let field = recipientField
        else { return }
        
        let action: CheckoutRecipientAction = .updateField(field)
        
        actions.value = action
        
    }

    @objc
    public final func updateLastName(_ textField: UITextField) {
        
        recipientField?.lastNameField.value = textField.text
        
        guard
            let field = recipientField
        else { return }
        
        let action: CheckoutRecipientAction = .updateField(field)
        
        actions.value = action
        
    }
    
    @objc
    public final func showPersonTitlePicker(_ button: UIButton) {
        
        guard
            let field = recipientField
        else { return }
        
        let action: CheckoutRecipientAction = .showPersonTitlePicker(field)
        
        actions.value = action
        
    }

    @objc
    public final func updatePhoneNumber(_ textField: UITextField) {
        
        recipientField?.phoneNumberField.value = textField.text
        
        guard
            let field = recipientField
        else { return }
        
        let action: CheckoutRecipientAction = .updateField(field)
        
        actions.value = action
        
    }

}
