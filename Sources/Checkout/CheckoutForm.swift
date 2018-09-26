//
//  CheckoutForm.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/27.
//

// MARK: - CheckoutForm

public struct CheckoutForm: ExpressibleByArrayLiteral {
    
    internal let storage: CheckoutStorage
    
    public init(
        fields: [CheckoutField]
    ) { self.storage = CheckoutStorage(elements: fields) }
    
    public init(arrayLiteral fields: CheckoutField...) { self.init(fields: fields) }
    
    public func validateAll() throws -> AnyCollection<CheckoutResult> { return try storage.validateAll() }
    
}
