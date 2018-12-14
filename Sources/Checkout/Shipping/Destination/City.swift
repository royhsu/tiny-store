//
//  City.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/14.
//

// MARK: - City

public protocol City {
    
    var rawValue: String { get }
    
    var name: String { get }
    
    init?(rawValue: String)
    
}
