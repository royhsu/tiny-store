//
//  CheckoutItemSelectionField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/2.
//

// MARK: - CheckoutItemSelectionField

public struct CheckoutItemSelectionField: Field {
    
    public let selection: Observable<Bool>
    
    public var content: Observable<Bool> { return selection }
    
    public let rules: [AnyValidationRule<Bool>] = []
    
    public let isRequired = true
    
    public init(selection: Observable<Bool>) { self.selection = selection }
    
}
