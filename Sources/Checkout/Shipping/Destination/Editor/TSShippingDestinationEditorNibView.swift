//
//  TSShippingDestinationEditorNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorNibView

internal final class TSShippingDestinationEditorNibView: UIView {

    @IBOutlet
    internal private(set) final weak var contentView: UIView!

    @IBOutlet
    internal private(set) final weak var floatingView: UIView!

    @IBOutlet
    internal private(set) final weak var floatingViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet
    private final weak var titleLabel: UILabel! {

        didSet {

            titleLabel.text = NSLocalizedString(
                "You can label this destination\n(For example: Home or Company)",
                comment: ""
            )

        }

    }

    @IBOutlet
    internal private(set) final weak var titleTextField: TSTextField! {

        didSet {

            titleTextField.placeholder = NSLocalizedString(
                "Name",
                comment: ""
            )

        }

    }

}
