//
//  UIShippingDestinationViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/16.
//

// MARK: - UIShippingDestinationViewController

public protocol ShippingRecipient {
    
    var name: Content<String> { get }
    
}

public protocol ShippingAddress {
    
    var title: Content<String> { get }
    
    var postalCode: Content<String> { get }
    
    var country: Content<String> { get }
    
    var state: Content<String> { get }
    
    var city: Content<String> { get }
    
    var line1: Content<String> { get }
    
    var line2: Content<String> { get }
    
}

public protocol ShippingDestination {
    
    var recipient: ShippingRecipient { get }
    
    var address: ShippingAddress { get }
    
}

public protocol ShippingDestinationController {
    
    var destination: ShippingDestination? { get set }
    
}

public final class UIShippingDestinationViewController: UIViewController, ShippingDestinationController {
    
    private final lazy var destinationView: UIShippingDestinationView = {
        
        return UIView.loadView(
            UIShippingDestinationView.self,
            from: Bundle(for: UIShippingDestinationView.self)
        )!
        
    }()
    
    public final var destination: ShippingDestination? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            renderView()
            
            observeModelChanges()
            
            handleViewActions()
            
        }
        
    }
    
    public final var edit: ( () -> Void )?
    
    fileprivate final var observations: [Observation] = []
    
    public init(_ destination: ShippingDestination? = nil) {
        
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
     
        renderView()
        
        observeModelChanges()
        
        handleViewActions()
        
        destinationView.editButton.addTarget(
            self,
            action: #selector(editDestination),
            for: .touchUpInside
        )
        
    }
    
    @objc
    public final func editDestination(_ sender: Any) { edit?() }
    
    fileprivate final func renderView() {
        
        guard let destination = destination else { return }
        
        let name = destination.recipient.name.property.value ?? "Unknown"
        
        destinationView.recipientLabel.text = "Recipient: \(name)"

        destinationView.cardTitleLabel.text = destination.address.title.property.value

        destinationView.cardAddressLabel.text = destination.address.line1.property.value
        
    }
    
    fileprivate final func observeModelChanges() { }
    
    fileprivate final func handleViewActions() { }
    
}
