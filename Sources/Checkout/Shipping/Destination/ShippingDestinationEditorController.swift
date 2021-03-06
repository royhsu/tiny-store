//
//  ShippingDestinationEditorController.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/6.
//

// MARK: - ShippingDestinationEditorController

public final class ShippingDestinationEditorController: ViewController {

    public final class Destination: DSL {

        public enum Element: LegacyViewCollection {

            case state(LegacyViewCollection)

            case district(LegacyViewCollection)

            case street(LegacyViewCollection)

            public var count: Int {

                switch self {

                case let .state(collection): return collection.count

                case let .district(collection): return collection.count

                case let .street(collection): return collection.count

                }

            }

            public func view(at index: Int) -> View {

                switch self {

                case let .state(collection): return collection.view(at: index)

                case let .district(collection): return collection.view(at: index)

                case let .street(collection): return collection.view(at: index)

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

    private final lazy var collectionViewController: LegacyCollectionViewController = {

        let controller = LegacyCollectionViewController()

        controller.collectionView.applyLayout(LegacyListViewLayout.self)

        controller.collectionView.sections = destination

        return controller

    }()

    public final let destination: Destination

    public init(destination: Destination? = nil) {

        self.destination = destination ?? Destination()

        super.init(
            nibName: nil,
            bundle: nil
        )

    }

    public required init?(coder aDecoder: NSCoder) {

        self.destination = Destination()

        super.init(coder: aDecoder)

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        addChild(collectionViewController)

        view.wrapSubview(collectionViewController.view)

        collectionViewController.didMove(toParent: self)

    }

}
