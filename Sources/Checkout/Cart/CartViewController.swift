//
//  CartViewController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CartViewController

public final class CartViewController: ViewController {

    private final lazy var collectionViewController: CollectionViewController = {

        let controller = CollectionViewController()

        controller.collectionViewLayout = ListViewLayout()

        return controller

    }()

    private final var elementObservations: [Observation] = [] 
    
    public final var elements: ElementCollection<CartElement> = [] {
        
        didSet {
            
            guard isViewLoaded else { return }
            
            collectionViewController.sections = elements
            
            collectionViewController.collectionView?.reloadData()
            
            totalAmount = elements.totalAmount
            
            observeElements()
            
        }
        
    }
    
    public private(set) final var totalAmount: Double = 0.0 {
        
        didSet { totalAmountDidChange?(self) }
        
    }
    
    public final var totalAmountDidChange: ( (CartViewController) -> Void )?

    public final override func viewDidLoad() {

        super.viewDidLoad()
        
        collectionViewController.sections = elements

        addChild(collectionViewController)

        view.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)
        
        totalAmount = elements.totalAmount
        
        observeElements()

    }
    
    private final func observeElements() {
        
        elementObservations = []

        for element in elements {
            
            switch element {

            case let .item(controller):

                let observations = [
                    controller.item?.isSelected.observe { [weak self] _ in

                        guard let self = self else { return }
                        
                        self.totalAmount = self.elements.totalAmount

                    },
                    controller.item?.price.observe { [weak self] _ in

                        guard let self = self else { return }
                        
                        self.totalAmount = self.elements.totalAmount

                    },
                    controller.item?.quantity.observe { [weak self] _ in

                        guard let self = self else { return }
                        
                        self.totalAmount = self.elements.totalAmount

                    }
                ]
                
                elementObservations.append(
                    contentsOf: observations.compactMap { $0 }
                )

            }

        }

    }

}

// MARK: - Total Amount

fileprivate extension ElementCollection where Element == CartElement {

    fileprivate var totalAmount: Double {

        let items: [CartItem] = compactMap { element in

            guard case let .item(controller) = element else { return nil }

            return controller.item

        }

        return items.reduce(0.0) { result, item in

            if item.isSelected.value == false { return result }

            let quantity = item.quantity.value ?? 0

            let price = item.price.value ?? 0.0

            let amount = price * Double(quantity)

            return result + amount

        }

    }

}
