//
//  TSModel.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSModel

public struct TSModel<Value> {

    public var value: Value? {

        didSet {

            let newValue = value

            let liveObservations = observations.filter { $0.observer != nil }

            observations = liveObservations

            let liveBindings = bindings.filter { $0.target != nil }

            bindings = liveBindings

            #warning("prevent accessing race conditions.")
            DispatchQueue.main.async {

//            let change: ObservedChange<Value> =
//                isInitialValue
//                    ? .initial(value: newValue)
//                    : .changed(
//                        oldValue: oldValue,
//                        newValue: newValue
//            )

                liveObservations.forEach {

                    $0.notify(
                        with: .changed(
                            oldValue: oldValue,
                            newValue: newValue
                        )
                    )

                }

                liveBindings.forEach { $0.update(with: newValue) }

            }

        }

    }

    public var rules: [AnyValidationRule<Value>]

    public var isRequired: Bool

    private var observations: [AnyModelObservation<Value>] = []

    private var bindings: [AnyBinding<Value>] = []

    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {

        self.value = value

        self.rules = rules

        self.isRequired = isRequired

    }

}

// MARK: - Binding

internal protocol ModelObservation {

    associatedtype Value

    var observer: AnyObject? { get }

    func notify(with change: ObservedChange<Value>)

}

internal struct AnyModelObservation<Value>: ModelObservation {

    internal weak var observer: AnyObject?

    private let _notify: (_ change: ObservedChange<Value>) -> Void

    internal init<O: ModelObservation>(_ o: O) where O.Value == Value {

        self.observer = o.observer

        self._notify = o.notify

    }

    internal func notify(with change: ObservedChange<Value>) { _notify(change) }

}

public extension TSModel {

    private struct _Observation<Observer: AnyObject, Value>: ModelObservation, Observation {

        private weak var _observer: Observer?

        internal var observer: AnyObject? { return _observer }

        private let handler: (
            _ observer: Observer,
            _ change: ObservedChange<Value>
        )
        -> Void

        internal init(
            _ observer: Observer,
            _ handler: @escaping (
                _ observer: Observer,
                _ change: ObservedChange<Value>
            )
            -> Void
        ) {

            self._observer = observer

            self.handler = handler

        }

        internal func notify(with change: ObservedChange<Value>) {

            guard let observer = _observer else { return }

            handler(
                observer,
                change
            )

        }

    }

    public mutating func addObserver<Observer: AnyObject>(
        _ observer: Observer,
        handler: @escaping (
            _ observer: Observer,
            _ change: ObservedChange<Value>
        )
        -> Void
    )
    -> Observation {

        let observation = _Observation(
            observer,
            handler
        )

        observations.append(
            AnyModelObservation(observation)
        )

        return observation

    }

    private struct NonnullValueBinding<Target: AnyObject, Value>: Binding {

        private weak var _target: Target?

        internal var target: AnyObject? { return _target }

        private let keyPath: ReferenceWritableKeyPath<Target, Value>

        internal init(
            target: Target,
            keyPath: ReferenceWritableKeyPath<Target, Value>
        ) {

            self._target = target

            self.keyPath = keyPath

        }

        internal func update(with value: Value?) {

            if let value = value { _target?[keyPath: keyPath] = value }

        }

    }

    private struct NullableValueBinding<Target: AnyObject, Value>: Binding {

        private weak var _target: Target?

        internal var target: AnyObject? { return _target }

        private let keyPath: ReferenceWritableKeyPath<Target, Value?>

        internal init(
            target: Target,
            keyPath: ReferenceWritableKeyPath<Target, Value?>
        ) {

            self._target = target

            self.keyPath = keyPath

        }

        internal func update(with value: Value?) { _target?[keyPath: keyPath] = value }

    }

    public mutating func bind<Target: AnyObject>(
        to target: Target,
        for keyPath: ReferenceWritableKeyPath<Target, Value>
    ) {

        let binding = NonnullValueBinding(
            target: target,
            keyPath: keyPath
        )

        binding.update(with: value)

        bindings.append(
            AnyBinding(binding)
        )

    }

    public mutating func bind<Target: AnyObject>(
        to target: Target,
        for keyPath: ReferenceWritableKeyPath<Target, Value?>
    ) {

        let binding = NullableValueBinding(
            target: target,
            keyPath: keyPath
        )

        binding.update(with: value)

        bindings.append(
            AnyBinding(binding)
        )

    }

}

// MARK: - Validation

public extension TSModel {

    @discardableResult
    public func validate() throws -> Value? {

        if isRequired {

            let value = try self.value.explicitValidated(
                by: NonNullRule()
            )

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }
        else {

            guard let value = value else { return nil }

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }

    }

}
