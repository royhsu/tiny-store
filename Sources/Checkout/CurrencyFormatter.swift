//
//  CurrencyFormatter.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/15.
//

// MARK: - CurrencyFormatter

public protocol CurrencyFormatter {

    func string(from price: Double) -> String

}
