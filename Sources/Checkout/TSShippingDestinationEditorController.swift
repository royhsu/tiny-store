//
//  TSShippingDestinationEditorController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSShippingDestinationEditorController

open class TSShippingDestinationEditorController: UIViewController {
    
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
        
        return UIView.loadView(
            TSShippingDestinationEditorRecipientNibView.self,
            from: Bundle(for: TSShippingDestinationEditorRecipientNibView.self)
        )!
        
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
    
        return UIView.loadView(
            TSShippingDestinationEditorAddressNibView.self,
            from: Bundle(for: TSShippingDestinationEditorAddressNibView.self)
        )!
    
    }()
    
    private final let addressFooterView: UIView = {
        
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [ view.heightAnchor.constraint(equalToConstant: 8.0) ]
        )
        
        return view
        
    }()
    
    public init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(collectionViewController)
        
        view.wrapSubview(
            collectionViewController.view,
            within: \.layoutMarginsGuide
        )
        
        collectionViewController.didMove(toParent: self)
        
        let button = TSButton()
        
        button.setTitle(
            NSLocalizedString(
                "City",
                comment: ""
            ),
            for: .normal
        )
        
        collectionViewController.collectionView.sections = [
            [
                button,
                recipientHeaderView,
                recipientView,
                recipientFooterView,
                addressHeaderView,
                addressView,
                addressFooterView
            ]
        ]
        
    }
    
}
