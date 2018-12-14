//
//  TSShippingDestinationCardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - TSShippingDestinationCardViewController

public final class TSShippingDestinationCardViewController: UIViewController {

    private final lazy var cardView: TSShippingDestinationCardNibView = {

        return UIView.loadView(
            TSShippingDestinationCardNibView.self,
            from: Bundle(for: TSShippingDestinationCardNibView.self)
        )!

    }()

    private final var recipientObservations: [Observation] = []

    public final var recipient: ShippingRecipient {

        didSet {

            guard isViewLoaded else { return }

            updateRecipientView()

            let observations = [
                recipient.firstName.observe { [weak self] _ in self?.updateRecipientView() },
                recipient.lastName.observe { [weak self] _ in self?.updateRecipientView() }
            ]
            
            recipientObservations = observations.compactMap { $0 }

        }

    }

    private final var addressObservations: [Observation] = []

    public final var address: ShippingAddress {

        didSet {

            guard isViewLoaded else { return }

            updateAddressView()

            let observations = [
                address.line1.observe { [weak self] _ in self?.updateAddressView() },
                address.line2.observe { [weak self] _ in self?.updateAddressView() }
            ]
            
            addressObservations = observations.compactMap { $0 }

        }

    }

    public final var editDestinationHandler: ( (TSShippingDestinationCardViewController) -> Void )?

    public init(
        recipient: ShippingRecipient? = nil,
        address: ShippingAddress? = nil
    ) {

        self.recipient = recipient ?? DefaultShippingRecipient()

        self.address = address ?? DefaultShippingAddress()

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) {

        self.recipient = DefaultShippingRecipient()

        self.address = DefaultShippingAddress()

        super.init(coder: aDecoder)

    }

    public final override func loadView() { view = cardView }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        updateRecipientView()

        updateAddressView()
        
        let recipientObservations = [
            recipient.firstName.observe { [weak self] _ in self?.updateRecipientView() },
            recipient.lastName.observe { [weak self] _ in self?.updateRecipientView() }
        ]
        
        self.recipientObservations = recipientObservations.compactMap { $0 }
        
        let addressObservations = [
            address.line1.observe { [weak self] _ in self?.updateAddressView() },
            address.line2.observe { [weak self] _ in self?.updateAddressView() }
        ]
        
        self.addressObservations = addressObservations.compactMap { $0 }

        cardView.editButton.addTarget(
            self,
            action: #selector(editDestination),
            for: .touchUpInside
        )

    }

    @objc
    public final func editDestination(_ sender: Any) { editDestinationHandler?(self) }

    private final func updateRecipientView() {

        if let fullName = recipient.fullName {

            let recipientText = NSLocalizedString(
                "Recipient",
                comment: ""
            )
            
            cardView.recipientLabel.text = "\(recipientText): \(fullName)"

        }
        else { cardView.recipientLabel.text = nil }

    }

    private final func updateAddressView() { cardView.addressLabel.text = address.fullLine }

}

// MARK: - ShippingRecipient

fileprivate extension ShippingRecipient {

    fileprivate var fullName: String? {

        guard
            let firstName = firstName.value,
            let lastName = lastName.value
        else { return nil }

        #warning("localization.")
        return "\(firstName) \(lastName)"

    }

}

// MARK: - ShippingAddress

fileprivate extension ShippingAddress {

    fileprivate var fullLine: String? {

        guard
            let line1 = line1.value,
            let line2 = line2.value
        else { return nil }

        return "\(line1)\n\(line2)"

    }

}
