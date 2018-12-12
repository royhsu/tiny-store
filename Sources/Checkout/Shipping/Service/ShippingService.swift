//
//  ShippingService.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/13.
//

// MARK: - ShippingService

public protocol ShippingService {

    var isSelected: Model<Bool> { get set }

    var title: Model<String> { get set }

    var price: Model<Double> { get set }

}
