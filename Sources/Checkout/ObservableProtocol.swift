//
//  ObservableProtocol.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/12/4.
//

#warning("move into TinyCore.")

public protocol ObservableProtocol {
    
    associatedtype Value
    
    var value: Value? { get set }
    
    func observe(
        _ observer: @escaping (_ change: ObservedChange<Value>) -> Void
    )
    -> Observation
    
}
