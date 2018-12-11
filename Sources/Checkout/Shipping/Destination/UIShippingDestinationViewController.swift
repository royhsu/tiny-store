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
    
    var destination: NewShippingDestination? {
        
        didSet {
            
            guard isViewLoaded && isDestinationBound else { return }
            
            renderRecipientLabel()
            
            addObservers()
            
        }
        
    }
    
    public final var editDestinationHandler: ( (UIShippingDestinationViewController) -> Void )?
    
    public init(_ destination: NewShippingDestination? = nil) {
        
        self.destination = destination
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
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
        
        let observations = [
            destination?.recipient.firstName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            },
            destination?.recipient.lastName.addObserver(self) { [weak self] _, _ in
                
                self?.renderRecipientLabel()
                
            }
        ]
        
        self.observations = observations.compactMap { $0 }
        
    }
    
    private final func renderRecipientLabel() {
        
        guard let destination = destination else { return }
        
        var recipient: String?

        if let fullName = destination.recipient.fullName {
            
            #warning("localization")
            recipient = "Recipient: \(fullName)"
            
        }
        
        destinationView.recipientLabel.text = recipient
        
    }
    
}
