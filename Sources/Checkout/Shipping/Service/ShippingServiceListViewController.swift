//
//  ShippingServiceListViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - ShippingServiceListViewController

public final class ShippingServiceListViewController: ViewController {
    
    private final lazy var collectionViewController: CollectionViewController = {
        
        let controller = CollectionViewController()
        
        controller.collectionViewLayout = ListViewLayout()
        
        return controller
        
    }()
    
    private final var elementObservations: [Observation] = []
    
    public final var elements: ElementCollection<ShippingServiceElement> = [] {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            collectionViewController.sections = elements
            
            collectionViewController.collectionView?.reloadData()
            
            updateSelectedElement()
            
            observeElements()
            
        }
        
    }
    
    private final var selectedIndexObservation: Observation?
    
    public final let selectedIndex = Model<Int>()
    
    public final var selectedService: ShippingService? {
        
        guard
            let selectedIndex = selectedIndex.value,
            selectedIndex < elements.count
        else { return nil }
        
        let element: ShippingServiceElement = elements[selectedIndex]
        
        guard case let .item(controller) = element else { return nil }
        
        return controller.service
        
    }
    
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
        
        for element in elements {
        
            switch element {
                
            case let .item(controller):
                
                let isSelected: Bool
                
                if
                    let selectedIndex = selectedIndex.value,
                    selectedIndex < elements.count { isSelected = true }
                else { isSelected = false }
                
                controller.service?.isSelected.value = isSelected
                
            }
            
        }
    }
    
    private final func observeSelectedIndex() {
        
        selectedIndexObservation = selectedIndex.observe { [weak self] result in
            
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
                
                return controller.service?.isSelected.observe { result in
                    
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
