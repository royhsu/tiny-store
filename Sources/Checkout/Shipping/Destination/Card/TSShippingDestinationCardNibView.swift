//
//  TSShippingDestinationCardNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - TSShippingDestinationCardNibView

internal final class TSShippingDestinationCardNibView: UIView {

    @IBOutlet
    internal private(set) final weak var recipientLabel: UILabel! {

        didSet { recipientLabel.text = nil }

    }

    @IBOutlet
    internal private(set) final weak var editButton: UIButton! {

        didSet {

            editButton.setTitle(
                NSLocalizedString(
                    "Edit",
                    comment: ""
                ),
                for: .normal
            )

        }

    }

    @IBOutlet
    private final weak var cardView: UIView! {

        didSet { cardView.layer.cornerRadius = 3.0 }

    }

    @IBOutlet
    internal private(set) final weak var titleLabel: UILabel! {

        didSet { titleLabel.text = nil }

    }

    @IBOutlet
    internal private(set) final weak var addressLabel: UILabel! {

        didSet { addressLabel.text = nil }

    }

    internal final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
