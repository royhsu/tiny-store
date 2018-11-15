//
//  PriceFormatter.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - PriceFormatter

public protocol PriceFormatter {
    
    func string(from price: Double) -> String
    
}
