//
//  AddressState.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/29.
//

// MARK: - AddressState

public protocol AddressState {

    var rawValue: String { get }

    var name: String { get }
}
