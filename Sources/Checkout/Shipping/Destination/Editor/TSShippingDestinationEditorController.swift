//
//  TSShippingDestinationEditorController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorController

open class TSShippingDestinationEditorController: UIViewController {

    private final lazy var editorView: TSShippingDestinationEditorNibView = {

        let view = UIView.loadView(
            TSShippingDestinationEditorNibView.self,
            from: Bundle(for: TSShippingDestinationEditorNibView.self)
        )!

        view.backgroundColor = nil
        
        view.titleTextField.textDidChange = {  [weak self] textField in self?.address.title.value = textField.text }

        view.titleTextField.shouldReturn = { [weak self] textField in

            let nextResponder = self?.nextResponder(of: textField)

            nextResponder?.becomeFirstResponder()

            return false

        }

        return view

    }()

    private final lazy var collectionViewController: CollectionViewController = {

        let controller = CollectionViewController()

        controller.collectionViewLayout = ListViewLayout()

        return controller

    }()

    private final let recipientHeaderView: TSSectionHeaderView = {

        let view = TSSectionHeaderView()

        view.title = NSLocalizedString(
            "Recipient",
            comment: ""
        )

        return view

    }()

    private final lazy var recipientView: TSShippingDestinationEditorRecipientNibView = {

        let view = UIView.loadView(
            TSShippingDestinationEditorRecipientNibView.self,
            from: Bundle(for: TSShippingDestinationEditorRecipientNibView.self)
        )!

        view.firstNameTextField.returnKeyType = .next

        view.firstNameTextField.textDidChange = { [weak self] textField in self?.recipient.firstName.value = textField.text }

        view.firstNameTextField.shouldReturn = { [weak self] textField in

            let nextResponder = self?.nextResponder(of: textField)

            nextResponder?.becomeFirstResponder()

            return false

        }

        view.lastNameTextField.returnKeyType = .next

        view.lastNameTextField.textDidChange = { [weak self] textField in self?.recipient.lastName.value = textField.text }

        view.lastNameTextField.shouldReturn = { [weak self] textField in

            let nextResponder = self?.nextResponder(of: textField)

            nextResponder?.becomeFirstResponder()

            return false

        }

        return view

    }()

    private final let recipientFooterView: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )

        return view

    }()

    private final let addressHeaderView: TSSectionHeaderView = {

        let view = TSSectionHeaderView()

        view.title = NSLocalizedString(
            "Address",
            comment: ""
        )

        return view

    }()

    private final lazy var addressView: TSShippingDestinationEditorAddressNibView = {

        let view = UIView.loadView(
            TSShippingDestinationEditorAddressNibView.self,
            from: Bundle(for: TSShippingDestinationEditorAddressNibView.self)
        )!

        view.street1TextField.returnKeyType = .next

        view.street1TextField.textDidChange = { [weak self] textField in self?.address.street1.value = textField.text }

        view.street1TextField.shouldReturn = { [weak self] textField in

            let nextResponder = self?.nextResponder(of: textField)

            nextResponder?.becomeFirstResponder()

            return false

        }

        view.street2TextField.returnKeyType = .next

        view.street2TextField.textDidChange = { [weak self] textField in self?.address.street2.value = textField.text }

        view.street2TextField.shouldReturn = { [weak self] textField in

            let nextResponder = self?.nextResponder(of: textField)

            nextResponder?.becomeFirstResponder()

            return false

        }

        view.stateButton.addTarget(
            self,
            action: #selector(handleAddressState),
            for: .touchUpInside
        )

        view.cityButton.addTarget(
            self,
            action: #selector(handleAddressCity),
            for: .touchUpInside
        )

        return view

    }()

    private final let addressFooterView: UIView = {

        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )

        return view

    }()

    private final lazy var responders: [UIResponder] = {

        return [
            recipientView.firstNameTextField,
            recipientView.lastNameTextField,
            addressView.street1TextField,
            addressView.street2TextField,
            editorView.titleTextField
        ]

    }()

    private final func nextResponder(of currentResponder: UIResponder) -> UIResponder? {

        guard
            let currentIndex = responders.firstIndex(of: currentResponder)
        else { return responders.first }

        let nextIndex = min(
            currentIndex + 1,
            responders.count - 1
        )

        return responders[nextIndex]

    }
    
    public final var recipient: ShippingRecipient {

        didSet {

            guard isViewLoaded else { return }

            recipient.firstName.bind(
                to: recipientView.firstNameTextField,
                keyPath: \.text
            )

            recipient.lastName.bind(
                to: recipientView.lastNameTextField,
                keyPath: \.text
            )

        }

    }

    public final var address: ShippingAddress {

        didSet {

            guard isViewLoaded else { return }
            
            address.title.bind(
                to: editorView.titleTextField,
                keyPath: \.text
            )

            address.street1.bind(
                to: addressView.street1TextField,
                keyPath: \.text
            )

            address.street2.bind(
                to: addressView.street2TextField,
                keyPath: \.text
            )

        }

    }

    public final var addressStateHandler: ( (TSShippingDestinationEditorController) -> Void )?

    public final var addressCityHandler: ( (TSShippingDestinationEditorController) -> Void )?

    public required init(
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

    open override func viewDidLoad() {

        super.viewDidLoad()

        recipient.firstName.bind(
            to: recipientView.firstNameTextField,
            keyPath: \.text
        )

        recipient.lastName.bind(
            to: recipientView.lastNameTextField,
            keyPath: \.text
        )

        address.street1.bind(
            to: addressView.street1TextField,
            keyPath: \.text
        )

        address.street2.bind(
            to: addressView.street2TextField,
            keyPath: \.text
        )

        view.wrapSubview(
            editorView,
            within: \.layoutMarginsGuide
        )

        addChild(collectionViewController)

        editorView.contentView.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)

        collectionViewController.sections = [
            [
                recipientHeaderView,
                recipientView,
                recipientFooterView,
                addressHeaderView,
                addressView,
                addressFooterView
            ]
        ]

    }

    @objc
    public final func handleAddressState(_ sender: Any) { addressStateHandler?(self) }

    @objc
    public final func handleAddressCity(_ sender: Any) { addressCityHandler?(self) }

}
