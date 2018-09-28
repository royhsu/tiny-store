//
//  UICheckoutShippingView.swift
//  PatissierStore
//
//  Created by Roy Hsu on 09/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - UICheckoutShippingView

public final class UICheckoutShippingView: UIView, Actionable {

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
    private final weak var cityButton: UIButton!

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
    private final weak var postalCodeButton: UIButton!

    @IBOutlet
    private final weak var addressLabel: UILabel!

    @IBOutlet
    private final weak var addressContentView: UIView!

    @IBOutlet
    private final weak var addressBottomBorderView: UIView!

    @IBOutlet
    private final weak var addressTextField: UITextField!

    private final var isLoaded = false

    public final let actions = Observable<Action>()

    public final var shipping: CheckoutShippingField? {

        didSet { updateUI() }

    }

    fileprivate final func updateUI() {
print("CCC", shipping)
        guard
            isLoaded
        else { return }
        
        cityButton.setTitle(
            shipping?.cityField.value?.name,
            for: .normal
        )
        
        postalCodeButton.setTitle(
            shipping?.postalCodeField.value,
            for: .normal
        )

        addressTextField.text = shipping?.addressField.value

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        isLoaded.toggle()

        setUpTitleLabel(
            cityLabel,
            title: NSLocalizedString(
                "City",
                comment: ""
            )
        )

        setUpContentView(cityContentView)

        setUpBorderView(cityBottomBorderView)

        setUpBorderView(cityLeftBorderView)

        setUpBorderView(cityRightBorderView)

        setUpActionButton(
            cityButton,
            action: #selector(showCityPicker)
        )

        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            postalCodeLabel,
            title: NSLocalizedString(
                "Postal Code",
                comment: ""
            )
        )

        setUpContentView(postalCodeContentView)

        setUpBorderView(postalCodeBottomBorderView)

        setUpBorderView(postalCodeLeftBorderView)

        setUpBorderView(postalCodeRightBorderView)

        setUpActionButton(
            postalCodeButton,
            action: #selector(showPostalCodePicker)
        )

        #warning("TODO: should be defined in the locale system.")
        setUpTitleLabel(
            addressLabel,
            title: NSLocalizedString(
                "Address",
                comment: ""
            )
        )

        setUpTextField(
            addressTextField,
            action: #selector(updateAddress)
        )

        setUpContentView(addressContentView)

        setUpBorderView(addressBottomBorderView)

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

        #warning("FIXME: multiple unneccessary changes are triggered while entering Traditional Chinese.")
        textField.addTarget(
            self,
            action: action,
            for: .editingChanged
        )

    }

    @objc
    public final func showCityPicker(_ button: UIButton) {

        guard
            let shipping = shipping
        else { return }

        let action: CheckoutShippingAction = .showCityPicker(shipping)

        actions.value = action

    }

    @objc
    public final func showPostalCodePicker(_ button: UIButton) {
        
        guard
            let shipping = shipping
        else { return }
        
        let action: CheckoutShippingAction = .showPostalCodePicker(shipping)
        
        actions.value = action
        
    }

    @objc
    public final func updateAddress(_ textField: UITextField) {

        guard
            let shipping = shipping
        else { return }

        shipping.addressField.value = textField.text

        let action: CheckoutShippingAction = .updateValue(shipping)

        actions.value = action

    }

}
