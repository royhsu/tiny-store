//
//  UICheckoutCartItemViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - UICheckoutCartItemViewController

public final class UICheckoutCartItemViewController: UIViewController, CheckoutCartItemController {
    
    private final let itemView: UICheckoutCartItemView = {
        
        let itemView = UIView.loadView(
            UICheckoutCartItemView.self,
            from: Bundle(for: UICheckoutCartItemView.self)
        )!
        
        itemView.quantityStepper.minimumValue = 1
        
        itemView.quantityStepper.maximumValue = 99
        
        return itemView
        
    }()
    
    public final var item: CheckoutCartItem? {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            renderView()

            observeModelChanges()

            handleViewActions()
            
        }
        
    }
    
    fileprivate final var observations: [Observation] = []
    
    fileprivate final var isSelectedUpdating = false
    
    private final let titleBinding: RenderableViewBinding<UILabel>
    
    private final let descriptionBinding: RenderableViewBinding<UILabel>
    
    private final let priceBinding: RenderableViewBinding<UICheckoutPriceView>
    
    private final let quantityBinding: InputableViewBinding<UICheckoutStepper>
    
    public init(_ item: CheckoutCartItem? = nil) {
        
        self.item = item
        
        self.titleBinding = RenderableViewBinding(
            model: item?.title ?? Model(),
            view: itemView.titleLabel
        )
        
        self.descriptionBinding = RenderableViewBinding(
            model: item?.description ?? Model(),
            view: itemView.descriptionLabel
        )
        
        self.priceBinding = RenderableViewBinding(
            model: item?.price ?? Model(),
            view: itemView.priceView
        )
        
        self.quantityBinding = InputableViewBinding(
            model: item?.quantity ?? Model(),
            view: itemView.quantityStepper
        )
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.titleBinding = RenderableViewBinding(
            model: Model(),
            view: itemView.titleLabel
        )
        
        self.descriptionBinding = RenderableViewBinding(
            model: Model(),
            view: itemView.descriptionLabel
        )
        
        self.priceBinding = RenderableViewBinding(
            model: Model(),
            view: itemView.priceView
        )
        
        self.quantityBinding = InputableViewBinding(
            model: Model(),
            view: itemView.quantityStepper
        )
        
        super.init(coder: aDecoder)
        
    }
    
    public final override func loadView() { view = itemView }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        renderView()
        
        observeModelChanges()
        
        handleViewActions()
        
    }
    
    fileprivate final func renderView() {
        
        guard let item = item else { return }
        
        itemView.isSelected = item.isSelected.property.value ?? true
        
    }
    
    fileprivate final func observeModelChanges() {
        
        guard let item = item else { return }
        
        observations = [
            item.isSelected.property.observe { [weak self] change in
                
                guard let self = self else { return }
                
                self.isSelectedUpdating = true
                
                DispatchQueue.main.async {
                    
                    self.itemView.isSelected = change.currentValue ?? false
                    
                    self.isSelectedUpdating = false
                    
                }
                
            }
        ]
        
    }
    
    fileprivate final func handleViewActions() {
        
        itemView.isSelectedDidChange = { [weak self] isSelected in
            
            guard
                let self = self,
                let item = self.item
            else { return }
            
            if self.isSelectedUpdating { return }
            
            item.isSelected.property.value = isSelected
            
        }
        
    }
    
}

//@available(*, deprecated: 1.0)
//public struct UICheckoutItemTemplate {
//
//    public var isSeparatorHidden = false
//
//    private let item: CheckoutCartItem
//
//    private var views: [UIView] {
//
//        return
//            isSeparatorHidden
//            ? [ topMarginView, itemView, bottomMarginView ]
//            : [ topMarginView, itemView, bottomMarginView, separatorView ]
//
//    }
//
//    private let itemView: UICheckoutCartItemView = UIView.loadView(
//        UICheckoutCartItemView.self,
//        from: Bundle(for: UICheckoutCartItemView.self)
//    )!
//
//    private let topMarginView: UIView = {
//
//        let view = UIView()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate(
//            [ view.heightAnchor.constraint(equalToConstant: 12.0) ]
//        )
//
//        return view
//
//    }()
//
//    private let bottomMarginView: UIView = {
//
//        let view = UIView()
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate(
//            [ view.heightAnchor.constraint(equalToConstant: 12.0) ]
//        )
//
//        return view
//
//    }()
//
//    private let separatorView: UIView = {
//
//        let view = UIView()
//
//        view.backgroundColor = .lightGray
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate(
//            [ view.heightAnchor.constraint(equalToConstant: 0.5) ]
//        )
//
//        return view
//
//    }()
//
//    public init(item: CheckoutCartItem) {
//
//        self.item = item
//
//        self.prepare()
//
//    }
//
//    fileprivate func prepare() {
//
//        itemView.isSelected = item.isSelected.property.value ?? true
//
//        itemView.isSelectedDidChange = { self.item.isSelected.property.value = $0 }
//
//        itemView.titleLabel.text = item.title.property.value
//
//        itemView.descriptionLabel.text = item.description.property.value
//
//        let price = item.price.property.value ?? 0.0
//
//        #warning("add currency formatter.")
//        itemView.priceLabel.text = "$ \(price)"
//
//        itemView.quantityStepper.minimumValue = 1
//
//        itemView.quantityStepper.maximumValue = 99
//
//        itemView.quantityStepper.value = item.quantity.property.value ?? 1
//
//        itemView.quantityStepper.valueDidChange = { self.item.quantity.property.value = $0 }
//
//    }
//
//    public var numberOfViews: Int { return views.count }
//
//    public func view(at index: Int) -> View { return views[index] }
//
//}
