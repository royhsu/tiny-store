//
//  CheckoutDashboard.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - CheckoutDashboard

public struct CheckoutDashboard {

    public let subTotal: Observable<Double>

    public let shipping: Observable<Double>

    public var payTotal: Double {

        let subTotal = self.subTotal.value ?? 0.0

        let shipping = self.shipping.value ?? 0.0

        return subTotal + shipping

    }

    public init(
        subTotal: Double = 0.0,
        shipping: Double = 0.0
    ) {

        self.subTotal = Observable(subTotal)

        self.shipping = Observable(shipping)

    }

}

public final class Dashboard: DSL {

    public enum Element: LegacyViewCollection {

        case subRow(DashboardRowController & ViewController)

        case action(DashboardActionController & ViewController)

        private var views: [View] {

            switch self {

            case let .subRow(controller): return [ controller.view ]

            case let .action(controller): return [ controller.view ]

            }

        }

        public var count: Int { return views.count }

        public func view(at index: Int) -> View { return views[index] }

    }

    fileprivate final var isPrepared = false

    public final var elements: [Element] {

        willSet { observations = [] }

        didSet {

            guard isPrepared else { return }

            handleElements()

        }

    }

    fileprivate final var observations: [Observation] = []

    public init() {

        self.elements = []

        self.prepare()

    }

    public init(arrayLiteral elements: Element...) {

        self.elements = elements

        self.prepare()

    }

    fileprivate final func prepare() {

        defer { isPrepared = true }

        handleElements()

    }

    fileprivate func handleElements() { }

    public final var count: Int { return elements.count }

    public final func section(at index: Int) -> Section { return elements[index] }

}
