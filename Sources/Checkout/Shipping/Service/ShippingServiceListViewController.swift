//
//  ShippingServiceListViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceListViewController

public final class NewShippingServiceListViewController: ViewController {
    
    private final lazy var collectionViewController: NewCollectionViewController = {
        
        let controller = NewCollectionViewController()
        
        controller.collectionViewLayout = NewListViewLayout()
        
        return controller
        
    }()
    
    private final var elementObservations: [Observation] = []
    
    public final var elements: ElementCollection<ShippingServiceElement> = [] {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            collectionViewController.sections = elements
            
            collectionViewController.collectionView?.reloadData()
            
            updateSelectedElement()
            
            observeSelectedIndex()
            
            observeElements()
            
        }
        
    }
    
    private final var selectedIndexObservation: Observation?
    
    public private(set) final var selectedIndex = Model<Int>()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionViewController.sections = elements
        
        addChild(collectionViewController)
        
        view.wrapSubview(collectionViewController.view)
        
        collectionViewController.didMove(toParent: self)
        
        updateSelectedElement()
        
        observeSelectedIndex()
        
        observeElements()
        
    }
    
    private final func updateSelectedElement() {
        
        if
            let selectedIndex = selectedIndex.value,
            selectedIndex < elements.count {
            
            let element: ShippingServiceElement = elements[selectedIndex]
            
            switch element {
                
            case let .item(controller): controller.service?.isSelected.value = true
                
            }
            
        }
        
    }
    
    private final func observeSelectedIndex() {
        
        selectedIndexObservation = selectedIndex.observe(on: .main) { [weak self] result in
            
            guard let self = self else { return }
            
            let selectedIndex = try? result.get()
            
            if let selectedIndex = selectedIndex as? Int {
                
                self.elements.enumerated().forEach { index, element in
                
                    switch element {
                        
                    case let .item(controller): controller.service?.isSelected.value = (selectedIndex == index)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private final func observeElements() {
        
        elementObservations = elements.enumerated().compactMap { [weak self] index, element in
            
            guard let self = self else { return nil }
            
            switch element {
                
            case let .item(controller):
                
                return controller.service?.isSelected.observe(on: .main) { result in
                    
                    let currentSelectedIndex = self.selectedIndex.value
                    
                    let isSameItemSelectionToggled = (currentSelectedIndex == index)
                    
                    let isSelected = try? result.get()
                    
                    if isSameItemSelectionToggled {
                        
                        if isSelected == false { self.selectedIndex.value = index }
                        
                    }
                    else {
                        
                        if isSelected == true { self.selectedIndex.value = index }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

public final class ShippingServiceListViewController: ViewController {

    private final lazy var collectionViewController: NewCollectionViewController = {

        let controller = NewCollectionViewController()
        
        controller.collectionViewLayout = NewListViewLayout()
        
        controller.sections = list
        
        return controller

    }()

    public final let list: ShippingServiceElementCollection

    public init(list: ShippingServiceElementCollection? = nil) {

        self.list = list ?? ShippingServiceElementCollection()

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) {

        self.list = ShippingServiceElementCollection()

        super.init(coder: aDecoder)

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        addChild(collectionViewController)

        view.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)

    }

}
