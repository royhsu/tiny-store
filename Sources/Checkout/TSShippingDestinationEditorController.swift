//
//  TSShippingDestinationEditorController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorController

public struct NewShippingRecipient {
    
    public var firstName: TSModel<String>
    
    public var lastName: TSModel<String>
    
    public init(
        firstName: String? = nil,
        lastName: String? = nil
    ) {
        
        self.firstName = TSModel(
            value: firstName,
            rules: [ .notEmpty ]
        )
        
        self.lastName = TSModel(
            value: lastName,
            rules: [ .notEmpty ]
        )
        
    }

}

extension NewShippingRecipient: Decodable {
    
    private enum CodingKeys: CodingKey {
        
        case firstName, lastName
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let firstName = try container.decodeIfPresent(
            String.self,
            forKey: .firstName
        )
        
        let lastName = try container.decodeIfPresent(
            String.self,
            forKey: .lastName
        )
        
        self.init(
            firstName: firstName,
            lastName: lastName
        )
        
    }
    
}

public protocol NewShippingDestination: Decodable {
    
    var recipient: NewShippingRecipient { get }
    
    init(
        recipient: NewShippingRecipient?
    )
    
}

private enum ShippingDestinationCodingKeys: CodingKey {
    
    case recipient
    
}

extension NewShippingDestination {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ShippingDestinationCodingKeys.self)
        
        let recipient = try container.decodeIfPresent(
            NewShippingRecipient.self,
            forKey: .recipient
        )
        
        self.init(recipient: recipient)
        
    }
    
}

open class TSShippingDestinationEditorController: UIViewController, NewShippingDestination {
    
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
        
        view.firstNameTextField.shouldReturn = { [weak self] textField in
            
            let nextResponder = self?.nextResponder(of: textField)
            
            nextResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        view.lastNameTextField.returnKeyType = .next
        
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
        
        view.line1TextField.shouldReturn = { [weak self] textField in
            
            let nextResponder = self?.nextResponder(of: textField)
            
            nextResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        view.line2TextField.returnKeyType = .next
        
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
    
    private final var isRecipientBinded = false
    
    public final var recipient: NewShippingRecipient {
        
        didSet {
            
            guard isViewLoaded && isRecipientBinded else { return }
            
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
    
    public final var addressStateHandler: ( (TSShippingDestinationEditorController) -> Void )?
    
    public final var addressCityHandler: ( (TSShippingDestinationEditorController) -> Void )?
    
    public required init(
        recipient: NewShippingRecipient? = nil
    ) {
        
        self.recipient = recipient ?? NewShippingRecipient()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.recipient = NewShippingRecipient()
        
        super.init(coder: aDecoder)
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        recipient.firstName.bind(
            to: recipientView.firstNameTextField,
            for: \.text
        )
        
        recipient.lastName.bind(
            to: recipientView.lastNameTextField,
            for: \.text
        )
        
        isRecipientBinded = true
        
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
