//
//  CheckoutItemTitleField.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/1.
//

// MARK: - CheckoutItemTitleField

public struct CheckoutItemTitleField {
    
    public let title: Observable<String>
    
    public init(title: Observable<String>) { self.title = title }
    
}
