//
//  TSShippingDestinationEditorAddressNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorAddressNibView

internal final class TSShippingDestinationEditorAddressNibView: UIView {

    @IBOutlet
    internal private(set) final weak var stateButton: TSRoundedButton! {

        didSet {

            stateButton.setTitle(
                NSLocalizedString(
                    "State",
                    comment: ""
                ) ,
                for: .normal
            )

        }

    }

    @IBOutlet
    internal private(set) final weak var cityButton: TSRoundedButton! {

        didSet {

            cityButton.setTitle(
                NSLocalizedString(
                    "City",
                    comment: ""
                ) ,
                for: .normal
            )

        }

    }

    @IBOutlet
    internal private(set) final weak var street1TextField: TSTextField! {

        didSet {

            street1TextField.placeholder = NSLocalizedString(
                "Street 1 (Street, Road)",
                comment: ""
            )

        }

    }

    @IBOutlet
    internal private(set) final weak var street2TextField: TSTextField! {

        didSet {

            street2TextField.placeholder = NSLocalizedString(
                "Street 2 (Floor)",
                comment: ""
            )

        }

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
