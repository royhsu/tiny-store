//
//  Binding.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/8.
//

// MARK: - Binding

internal protocol Binding {
    
    associatedtype Value
    
    var target: AnyObject? { get }
    
    func update(with value: Value?)
    
}

// MARK: - AnyBinding

internal struct AnyBinding<Value>: Binding {
    
    internal weak var target: AnyObject?
    
    private let update: (Value?) -> Void
    
    internal init<B: Binding>(_ binding: B) where B.Value == Value {
        
        self.target = binding.target
        
        self.update = binding.update
        
    }
    
    internal func update(with value: Value?) { update(value) }
    
}
