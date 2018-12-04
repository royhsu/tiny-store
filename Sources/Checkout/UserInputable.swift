//
//  UserInputable.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/28.
//

// MARK: - UserInputable

public protocol UserInputable: AnyObject {
    
    associatedtype Value
    
    var didReceiveUserInput: ( (Value?) -> Void )? { get set }
    
}
