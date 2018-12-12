//
//  TSShippingServiceViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - TSShippingServiceViewController

public final class TSShippingServiceViewController: UIViewController, ShippingServiceController {

    private final lazy var serviceView: TSShippingServiceNibView = {

        let view = UIView.loadView(
            TSShippingServiceNibView.self,
            from: Bundle(for: TSShippingServiceNibView.self)
        )!
        
        view.selectionDidChange = { [weak self] view in self?.service?.isSelected.value = view.isSelected }
        
        return view

    }()
    
    private final var isServiceBound = false

    public final var service: ShippingService? {

        didSet {

            guard isViewLoaded && isServiceBound else { return }

            service?.isSelected.bind(
                transform: { $0 ?? false },
                to: serviceView,
                keyPath: \.isSelected
            )
            
            service?.title.bind(
                to: serviceView.titleLabel,
                keyPath: \.text
            )
            
            service?.price.bind(
                transform: { $0 ?? 0.0 },
                to: serviceView.priceView,
                keyPath: \.price
            )
            
        }

    }

    public init(_ service: ShippingService? = nil) {

        self.service = service

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    public final override func loadView() { view = serviceView }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        defer { isServiceBound = true }
     
        service?.isSelected.bind(
            transform: { $0 ?? false },
            to: serviceView,
            keyPath: \.isSelected
        )
        
        service?.title.bind(
            to: serviceView.titleLabel,
            keyPath: \.text
        )
        
        service?.price.bind(
            transform: { $0 ?? 0.0 },
            to: serviceView.priceView,
            keyPath: \.price
        )
        
    }

}
