//
//  TSShippingDestinationCardViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - TSShippingDestinationCardViewController

public final class TSShippingDestinationCardViewController: UIViewController {
    
    private final var observations: [Observation] = []
    
    private final lazy var cardView: TSShippingDestinationCardNibView = {
        
        return UIView.loadView(
            TSShippingDestinationCardNibView.self,
            from: Bundle(for: TSShippingDestinationCardNibView.self)
        )!
        
    }()
    
    private final var isDestinationBound = false
    
    public final var destination: ShippingDestination {
        
        didSet {
            
            guard isViewLoaded && isDestinationBound else { return }
            
            renderRecipientLabel()
            
            observations = [
                destination.recipient.firstName.addObserver(self) { [weak self] _, _ in
                    
                    self?.renderRecipientLabel()
                    
                },
                destination.recipient.lastName.addObserver(self) { [weak self] _, _ in
                    
                    self?.renderRecipientLabel()
                    
                }
            ]
            
        }
        
    }
    
    public final var editDestinationHandler: ( (TSShippingDestinationCardViewController) -> Void )?
    
    public init(_ destination: ShippingDestination? = nil) {
        
        self.destination = destination ?? DefaultShippingDestination()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.destination = DefaultShippingDestination()
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func loadView() { view = cardView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
     
        isDestinationBound = true
        
        renderRecipientLabel()
        
        observations = [
            destination.recipient.firstName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            },
            destination.recipient.lastName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            }
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
        
        var recipient: String?

        if let fullName = destination.recipient.fullName {
            
            #warning("localization")
            recipient = "Recipient: \(fullName)"
            
        }
        
        cardView.recipientLabel.text = recipient
        
    }
    
}

// MARK: - Full Name

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
