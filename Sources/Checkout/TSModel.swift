//
//  TSModel.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/7.
//

// MARK: - TSModel

private protocol Binding {
    
    associatedtype Value
    
    var target: AnyObject? { get }
    
    func update(with value: Value?)
    
}

private struct AnyBinding<Value>: Binding {
    
    private let update: (Value?) -> Void
    
    internal weak var target: AnyObject?
    
    internal init<B: Binding>(_ binding: B) where B.Value == Value {
        
        self.target = binding.target
        
        self.update = binding.update
        
    }
    
    internal func update(with value: Value?) { update(value) }
    
}

public struct TSModel<Value> {
    
    public var value: Value? {
        
        didSet {
            
            let liveBindings = bindings.filter { $0.target != nil }
            
            bindings = liveBindings
            
            liveBindings.forEach { $0.update(with: self.value) }
            
            print("New value: ", value)
            
        }
        
    }
    
    public var rules: [AnyValidationRule<Value>]
    
    public var isRequired: Bool
    
    private var bindings: [ AnyBinding<Value> ] = []
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {
        
        self.value = value
        
        self.rules = rules
        
        self.isRequired = isRequired
        
    }
 
    private struct _Binding<Target: AnyObject, Value>: Binding {
        
        internal var target: AnyObject? { return _target }
        
        private weak var _target: Target?
        
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
    
}

public extension TSModel {
    
    public mutating func bind<Target: AnyObject>(
        to target: Target,
        for keyPath: ReferenceWritableKeyPath<Target, Value?>
    ) {
        
        let binding = _Binding(
            target: target,
            keyPath: keyPath
        )

        bindings.append(
            AnyBinding(binding)
        )
        
    }
    
}

public protocol BindingTarget: AnyObject {
    
    associatedtype Value
    
    var keyPath: ReferenceWritableKeyPath<Self, Value>? { get }
    
}

//public final class AnyBindingTarget<Value> {
//
//    public let keyPath: ReferenceWritableKeyPath<AnyBindingTarget, Value>
//
//    public init(
//
//}

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
