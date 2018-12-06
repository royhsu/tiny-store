//
//  ShippingDestination.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MARK: - Destination

public protocol PostalCode {
    
    var rawValue: String { get }
    
    init?(rawValue: String)
    
}

extension ViewController: ViewCollection {
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return view }
    
}

extension InputableViewBinding: ViewCollection {
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return view }
    
}

public final class UIPostalCodeView<P: PostalCode>: UIView, UserInputable, ValueRenderable {

    private final var _postalCode: P? {
        
        didSet { print("New postal code", _postalCode) }
        
    }
    
    public final var postalCode: P? {
        
        get { return _postalCode }
        
        set {
            
            _postalCode = newValue
            
            if let postalCode = postalCode {
                
                didReceiveUserInput?(postalCode)
                
            }
            
        }
        
    }
    
    public final var didReceiveUserInput: ( (P) -> Void )?
    
    private final lazy var textFieldContainerView: UITextFieldContainerView = {
        
        let textField = UITextField()

        textField.placeholder = NSLocalizedString(
            "Postal Code",
            comment: ""
        )
        
        textField.keyboardType = .numberPad
        
        return UITextFieldContainerView(textField)
        
    }()
    
    public init() {
        
        super.init(frame: .zero)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    public final func render(with postalCode: P?) {
        
        _postalCode = postalCode
        
        textFieldContainerView.render(with: postalCode?.rawValue)
        
    }
    
    private final func load() {
        
        wrapSubview(textFieldContainerView)
        
        textFieldContainerView.didReceiveUserInput = { text in
            
            if let postalCode = P(rawValue: text) {
                
                self.postalCode = postalCode
                
            }
            else {
                
                self.postalCode = nil
                
                #warning("error handling. invalid input for a postal code.")
                
            }
            
        }
        
    }
    
}

public final class UIShippingDestination: DSL {
    
    public enum Element: ViewCollection {
        
        case postalCode(ViewCollection)
        
        public var numberOfViews: Int {
            
            switch self {
                
            case let .postalCode(collection): return collection.numberOfViews
                
            }
            
        }
        
        public func view(at index: Int) -> View {
            
            switch self {
                
            case let .postalCode(collection): return collection.view(at: index)
                
            }
        
        }
        
    }
    
    public final var elements: [Element]
    
    public init(
        elements: [Element] = []
    ) { self.elements = elements }
    
    public convenience init(arrayLiteral elements: Element...) { self.init(elements: elements) }
    
    public final var count: Int { return elements.count }
    
    public final func section(at index: Int) -> Section { return elements[index] }
    
}

public final class ShippingDestinationViewController: ViewController {
    
    private final lazy var collectionViewController: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionView.applyLayout(ListViewLayout.self)
        
        controller.collectionView.sections = destination
        
        return controller
        
    }()
    
    public final let destination: UIShippingDestination
    
    public init(destination: UIShippingDestination? = nil) {
        
        self.destination = destination ?? UIShippingDestination()
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.destination = UIShippingDestination()
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(collectionViewController)
        
        view.wrapSubview(collectionViewController.view)
        
        collectionViewController.didMove(toParent: self)
        
    }
    
}
