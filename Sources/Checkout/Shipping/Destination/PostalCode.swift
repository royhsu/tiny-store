//
//  PostalCode.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/5.
//

// MARK: - PostalCode

public protocol PostalCode {
    
    var rawValue: String { get }
    
    init?(rawValue: String)
    
}
