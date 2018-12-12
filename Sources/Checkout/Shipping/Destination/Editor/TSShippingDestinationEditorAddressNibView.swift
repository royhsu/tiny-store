//
//  TSShippingDestinationEditorAddressNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorAddressNibView

internal final class TSShippingDestinationEditorAddressNibView: UIView {

    @IBOutlet
    internal private(set) final weak var stateButton: TSButton! {

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
    internal private(set) final weak var cityButton: TSButton! {

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
    internal private(set) final weak var line1TextField: TSTextField! {

        didSet {

            line1TextField.placeholder = NSLocalizedString(
                "Line 1 (Street, Road)",
                comment: ""
            )

        }

    }

    @IBOutlet
    internal private(set) final weak var line2TextField: TSTextField! {

        didSet {

            line2TextField.placeholder = NSLocalizedString(
                "Line 2 (Floor)",
                comment: ""
            )

        }

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
