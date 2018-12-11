//
//  TSShippingDestinationEditorController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorController

open class TSShippingDestinationEditorController: UIViewController {
    
    private final lazy var _nibView: TSShippingDestinationEditorNibView = {
        
        let view = UIView.loadView(
            TSShippingDestinationEditorNibView.self,
            from: Bundle(for: TSShippingDestinationEditorNibView.self)
        )!
        
        view.backgroundColor = nil
        
        view.nameTextField.returnKeyType = .done
        
        view.nameTextField.shouldReturn = { [weak self] textField in
            
            let nextResponder = self?.nextResponder(of: textField)
                
            nextResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        return view
        
    }()
    
    private final lazy var collectionViewController: CollectionViewController = {
       
        let controller = CollectionViewController()

        controller.collectionView.applyLayout(ListViewLayout.self)
        
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
        
        view.line1TextField.returnKeyType = .next
        
        view.line1TextField.textDidChange = { [weak self] textField in self?.address.line1.value = textField.text }
        
        view.line1TextField.shouldReturn = { [weak self] textField in
            
            let nextResponder = self?.nextResponder(of: textField)
            
            nextResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        view.line2TextField.returnKeyType = .next
        
        view.line2TextField.textDidChange = { [weak self] textField in self?.address.line2.value = textField.text }
        
        view.line2TextField.shouldReturn = { [weak self] textField in
            
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
            addressView.line1TextField,
            addressView.line2TextField,
            _nibView.nameTextField
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
    
    private final var isRecipientBound = false
    
    public final var recipient: ShippingRecipient {
        
        didSet {
            
            guard isViewLoaded && isRecipientBound else { return }
            
            recipient.firstName.bind(
                to: recipientView.firstNameTextField,
                for: \.text
            )
            
            recipient.lastName.bind(
                to: recipientView.lastNameTextField,
                for: \.text
            )
            
        }
        
    }
    
    private final var isAddressBound = false
    
    public final var address: NewShippingAddress {
        
        didSet {
            
            guard isViewLoaded && isAddressBound else { return }
            
            address.line1.bind(
                to: addressView.line1TextField,
                for: \.text
            )
            
            address.line2.bind(
                to: addressView.line2TextField,
                for: \.text
            )
            
        }
        
    }
    
    public final var addressStateHandler: ( (TSShippingDestinationEditorController) -> Void )?
    
    public final var addressCityHandler: ( (TSShippingDestinationEditorController) -> Void )?
    
    public required init(
        recipient: ShippingRecipient? = nil,
        address: NewShippingAddress? = nil
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
        
        defer {
            
            isRecipientBound = true
            
            isAddressBound = true
            
        }
        
        recipient.firstName.bind(
            to: recipientView.firstNameTextField,
            for: \.text
        )
        
        recipient.lastName.bind(
            to: recipientView.lastNameTextField,
            for: \.text
        )
        
        address.line1.bind(
            to: addressView.line1TextField,
            for: \.text
        )
        
        address.line2.bind(
            to: addressView.line2TextField,
            for: \.text
        )
        
        view.wrapSubview(
            _nibView,
            within: \.layoutMarginsGuide
        )
        
        addChild(collectionViewController)
        
        _nibView.contentView.wrapSubview(collectionViewController.view)
        
        collectionViewController.didMove(toParent: self)
        
        collectionViewController.collectionView.sections = [
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
