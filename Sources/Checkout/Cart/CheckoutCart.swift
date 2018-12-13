//
//  CheckoutCart.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/9.
//

// MARK: - CheckoutCart

public final class CheckoutCart: DSL {

    public enum Element: ViewCollection {

        case item(CartItemController & ViewController)

        public var count: Int {

            switch self {

            case .item: return 1

            }

        }

        public func view(at index: Int) -> View {

            switch self {

            case let .item(controller): return controller.view

            }

        }

    }

    private final var isLoaded = false

    public final var elements: [Element] {

        willSet { observations = [] }
        
        didSet {

            guard isLoaded else { return }

            handleElements()

        }

    }

    private final var observations: [Observation] = []

    public final var totalAmount: Double { return elements.totalAmount }

    public final var totalAmountDidChange: ( (Double) -> Void )?

    public init(elements: [Element] = []) {

        self.elements = []

        self.load()

    }

    public convenience init(arrayLiteral elements: Element...) { self.init(elements: elements) }

    private final func load() {

        defer { isLoaded = true }

        handleElements()

    }

    private final func handleElements() {

        for element in elements {

            switch element {

            case let .item(controller):

                let observations = [
                    controller.item?.isSelected.observe { [weak self] _ in
                    
                        guard let self = self else { return }
                    
                        self.totalAmountDidChange?(self.totalAmount)
                    
                    },
                    controller.item?.price.observe { [weak self] _ in

                        guard let self = self else { return }

                        self.totalAmountDidChange?(self.totalAmount)

                    },
                    controller.item?.quantity.observe { [weak self] _ in

                        guard let self = self else { return }

                        self.totalAmountDidChange?(self.totalAmount)

                    }
                ]
                
                self.observations = observations.compactMap { $0 }

            }

        }

    }

    public final var count: Int { return elements.count }

    public final func section(at index: Int) -> Section { return elements[index] }

}

fileprivate extension Array where Element == CheckoutCart.Element {

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
