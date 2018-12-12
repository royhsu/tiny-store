//
//  DSL.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/11/20.
//

// MARK: - DSL

#warning("move into TinyKit.")
public protocol DSL: ExpressibleByArrayLiteral, SectionCollection {

    associatedtype Element: ViewCollection

    var elements: [Element] { get set }

}
