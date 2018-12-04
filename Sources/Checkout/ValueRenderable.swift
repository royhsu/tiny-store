//
//  ValueRenderable.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/4.
//

// MARK: - ValueRenderable

public protocol ValueRenderable: AnyObject {
    
    associatedtype Value
    
    func render(with value: Value?)
    
}
