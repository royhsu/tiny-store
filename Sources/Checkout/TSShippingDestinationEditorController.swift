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
    
    private final lazy var recipientView: TSShippingDestinationEditorRecipientNibView = {
        
        return UIView.loadView(
            TSShippingDestinationEditorRecipientNibView.self,
            from: Bundle(for: TSShippingDestinationEditorRecipientNibView.self)
        )!
        
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
        
        collectionViewController.collectionView.sections = [
            [ recipientView ]
        ]
        
    }
    
}
