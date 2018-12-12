//
//  TSShippingDestinationCardNibView.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - TSShippingDestinationCardNibView

public final class TSShippingDestinationCardNibView: UIView {

    @IBOutlet
    public private(set) final weak var recipientLabel: UILabel! {

        didSet {

            recipientLabel.adjustsFontForContentSizeCategory = true

            recipientLabel.font = .preferredFont(forTextStyle: .body)

            recipientLabel.numberOfLines = 1

            recipientLabel.text = nil

        }

    }

    @IBOutlet
    public private(set) final weak var editButton: UIButton! {

        didSet {

            editButton.setTitle(
                NSLocalizedString(
                    "Edit",
                    comment: ""
                ),
                for: .normal
            )

            editButton.titleLabel?.adjustsFontForContentSizeCategory = true

            editButton.titleLabel?.font = .preferredFont(forTextStyle: .body)

        }

    }

    @IBOutlet
    private final weak var cardView: UIView! {

        didSet {

            cardView.backgroundColor = .lightGray

            cardView.layer.cornerRadius = 3.0

        }

    }

    @IBOutlet
    public private(set) final weak var titleLabel: UILabel! {

        didSet {

            titleLabel.adjustsFontForContentSizeCategory = true

            titleLabel.font = .preferredFont(forTextStyle: .title3)

            titleLabel.numberOfLines = 1

            titleLabel.text = nil

        }

    }

    @IBOutlet
    public private(set) final weak var addressLabel: UILabel! {

        didSet {

            addressLabel.adjustsFontForContentSizeCategory = true

            addressLabel.font = .preferredFont(forTextStyle: .body)

            addressLabel.numberOfLines = 0

            addressLabel.text = nil

        }

    }

    public final override func awakeFromNib() {

        super.awakeFromNib()

        backgroundColor = nil

    }

}
