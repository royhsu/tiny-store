//
//  Inputable.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

// MARK: - Inputable

public protocol Inputable {
    
    associatedtype Value
    
    var input: Observable<Value> { get }
    
}

public protocol UserInputable {
    
    associatedtype Value
    
    var didReceiveUserInput: ( (Value?) -> Void )? { get set }
    
}
