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
            
            let liveBindings = bindings.filter { $0.target != nil }
            
            bindings = liveBindings
            
            liveBindings.forEach { $0.update(with: newValue) }
            
        }
        
    }
    
    public var rules: [AnyValidationRule<Value>]
    
    public var isRequired: Bool
    
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

public extension TSModel {
    
    private struct _Binding<Target: AnyObject, Value>: Binding {
        
        private weak var _target: Target?
        
        private let keyPath: ReferenceWritableKeyPath<Target, Value?>
        
        internal var target: AnyObject? { return _target }
        
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
        for keyPath: ReferenceWritableKeyPath<Target, Value?>
    ) {
        
        let binding = _Binding(
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
    
    public func validate() throws -> Value? {
        
        if isRequired {
            
            let value = try self.value.explicitlyValidated(
                by: NotNilRule()
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
