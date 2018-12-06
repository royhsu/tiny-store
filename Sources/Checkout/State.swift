//
//  State.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/29.
//

// MARK: - State

public protocol State {
    
    var rawValue: String { get }
    
    var name: String { get }
    
    init?(rawValue: String)
    
}
