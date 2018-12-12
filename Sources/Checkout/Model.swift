//
//  Model.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

// MARK: - Model

public final class Model<Value> {

    private final let storage: Observable<Value>

    public final var rules: [AnyValidationRule<Value>]

    public final var isRequired: Bool

    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {

        self.storage = Observable(value)

        self.rules = rules

        self.isRequired = isRequired

    }

}

// MARK: - ObservableProtocol

extension Model: ObservableProtocol {

    public final var value: Value? {

        get { return storage.value }

        set { storage.value = newValue }

    }

    public final func observe(
        _ observer: @escaping (ObservedChange<Value>) -> Void
    )
    -> Observation { return storage.observe(observer) }

}

// MARK: - Validation

public extension Model {

    public final func validate() throws -> Value? {

        if isRequired {

            let value = try storage.value.explicitValidated(
                by: NonNullRule()
            )

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }
        else {

            guard let value = storage.value else { return nil }

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }

    }

}
