//
//  DefaultCurrencyFormatter.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - DefaultCurrencyFormatter

internal struct DefaultCurrencyFormatter: CurrencyFormatter {
    
    internal func string(from price: Double) -> String { return "$ \(price)" }
    
}
