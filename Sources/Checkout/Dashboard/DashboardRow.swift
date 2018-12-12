//
//  DashboardRow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - DashboardRow

public protocol DashboardRow {

    var title: Model<String> { get }

    var amount: Model<Double> { get }

}
