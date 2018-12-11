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
    
    private final var isRecipientBound = false
    
    private final var recipientObservations: [Observation] = []
    
    public final var recipient: ShippingRecipient {
        
        didSet {
            
            guard isViewLoaded && isRecipientBound else { return }
            
            renderRecipientLabel()
            
            recipientObservations = [
                recipient.firstName.addObserver(self) { [weak self] _, _ in self?.renderRecipientLabel() },
                recipient.lastName.addObserver(self) { [weak self] _, _ in self?.renderRecipientLabel() }
            ]
            
        }
        
    }
    
    private final var isAddressBound = false
    
    private final var addressObservations: [Observation] = []
    
    public final var address: NewShippingAddress {
        
        didSet {
            
            guard isViewLoaded && isAddressBound else { return }
            
            renderAddressLabel()
            
            addressObservations = [
                address.line1.addObserver(self) { [weak self] _, _ in self?.renderAddressLabel() },
                address.line2.addObserver(self) { [weak self] _, _ in self?.renderAddressLabel() }
            ]
            
        }
        
    }
    
    public final var editDestinationHandler: ( (TSShippingDestinationCardViewController) -> Void )?
    
    public init(
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
    
    public final override func loadView() { view = cardView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
     
        defer {
            
            isRecipientBound = true
            
            isAddressBound = true
            
        }
        
        renderRecipientLabel()
        
        renderAddressLabel()
        
        recipientObservations = [
            recipient.firstName.addObserver(self) { [weak self] _, _ in self?.renderRecipientLabel() },
            recipient.lastName.addObserver(self) { [weak self] _, _ in self?.renderRecipientLabel() }
        ]
        
        addressObservations = [ address.line1.addObserver(self) { [weak self] _, _ in self?.renderAddressLabel() },
            address.line2.addObserver(self) { [weak self] _, _ in self?.renderAddressLabel() }
        ]
        
        cardView.editButton.addTarget(
            self,
            action: #selector(editDestination),
            for: .touchUpInside
        )
        
    }
    
    @objc
    public final func editDestination(_ sender: Any) { editDestinationHandler?(self) }
    
    private final func renderRecipientLabel() {
    
        if let fullName = recipient.fullName {
            
            #warning("localization")
            
            cardView.recipientLabel.text = "Recipient: \(fullName)"
            
        }
        else { cardView.recipientLabel.text = nil }
        
    }
    
    private final func renderAddressLabel() { cardView.addressLabel.text = address.fullLine }
    
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

fileprivate extension NewShippingAddress {
    
    fileprivate var fullLine: String? {
        
        guard
            let line1 = line1.value,
            let line2 = line2.value
        else { return nil }

        return "\(line1)\n\(line2)"
        
    }
    
}
