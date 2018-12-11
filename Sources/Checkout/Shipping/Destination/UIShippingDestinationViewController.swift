//
//  UIShippingDestinationViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - UIShippingDestinationViewController

internal extension NewShippingRecipient {
    
    internal var fullName: String? {
        
        guard
            let firstName = firstName.value,
            let lastName = lastName.value
        else { return nil }
        
        #warning("localization.")
        return "\(firstName) \(lastName)"
        
    }
    
}

public final class UIShippingDestinationViewController: UIViewController {
    
    private final var observations: [Observation] = []
    
    private final lazy var destinationView: UIShippingDestinationView = {
        
        return UIView.loadView(
            UIShippingDestinationView.self,
            from: Bundle(for: UIShippingDestinationView.self)
        )!
        
    }()
    
    private final var isDestinationBound = false
    
    public final var destination: NewShippingDestination {
        
        didSet {
            
            guard isViewLoaded && isDestinationBound else { return }
            
            renderRecipientLabel()
            
            addObservers()
            
        }
        
    }
    
    public final var editDestinationHandler: ( (UIShippingDestinationViewController) -> Void )?
    
    public init(_ destination: NewShippingDestination? = nil) {
        
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
    
    public final override func loadView() { view = destinationView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
     
        renderRecipientLabel()
        
        addObservers()
        
        destinationView.editButton.addTarget(
            self,
            action: #selector(editDestination),
            for: .touchUpInside
        )
        
    }
    
    @objc
    public final func editDestination(_ sender: Any) { editDestinationHandler?(self) }
    
    private final func addObservers() {
        
        observations = [
            destination.recipient.firstName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            },
            destination.recipient.lastName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            }
        ]
        
    }
    
    private final func renderRecipientLabel() {
        
        var recipient: String?

        if let fullName = destination.recipient.fullName {
            
            #warning("localization")
            recipient = "Recipient: \(fullName)"
            
        }
        
        print("TEST", recipient)
        
        destinationView.recipientLabel.text = recipient
        
    }
    
}
