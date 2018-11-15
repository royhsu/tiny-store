//
//  DefaultPriceFormatter.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - DefaultPriceFormatter

internal struct DefaultPriceFormatter: PriceFormatter {
    
    internal func string(from price: Double) -> String { return "$ \(price)" }
    
}
