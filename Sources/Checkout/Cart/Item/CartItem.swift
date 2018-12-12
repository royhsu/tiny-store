//
//  CartItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/9/28.
//

// MARK: - CartItem

public protocol CartItem {

    var isSelected: Model<Bool> { get set }

    var title: Model<String> { get set }

    var description: Model<String> { get set }

    var price: Model<Double> { get set }

    var quantity: Model<Int> { get set }

}
