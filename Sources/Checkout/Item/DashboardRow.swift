//
//  DashboardRow.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/11/22.
//

// MARK: - DashboardRow

public protocol DashboardRow {
    
    var title: Content<String> { get }
    
    var amount: Content<Double> { get }
    
}
